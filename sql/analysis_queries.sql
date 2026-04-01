-- Banking / Credit Card Product Strategy Analysis SQL
-- Data source in this repository:
--   - dim_customers(customer_id, age_group, city, occupation, gender, marital status, avg_income)
--   - fact_spends(customer_id, month, category, payment_type, spend)
--
-- NOTE:
-- The provided dataset does not include direct churn fields (Exited / IsActiveMember / NumOfProducts).
-- Queries below include churn-risk proxies based on spend behavior and engagement breadth.

-- =========================================================
-- 0) Standardized base view (column cleanup)
-- =========================================================
WITH base_customers AS (
    SELECT
        customer_id,
        age_group,
        city,
        occupation,
        gender,
        "marital status" AS marital_status,
        avg_income
    FROM dim_customers
)
SELECT *
FROM base_customers
LIMIT 10;


-- =========================================================
-- 1) KPI OVERVIEW
-- =========================================================
WITH customer_metrics AS (
    SELECT
        f.customer_id,
        SUM(f.spend) AS total_spend,
        AVG(f.spend) AS avg_transaction_spend,
        COUNT(*) AS transactions,
        COUNT(DISTINCT f.category) AS category_count,
        COUNT(DISTINCT f.payment_type) AS payment_type_count
    FROM fact_spends f
    GROUP BY f.customer_id
)
SELECT
    COUNT(*) AS total_customers,
    ROUND(AVG(total_spend), 2) AS avg_spend_per_customer,
    ROUND(AVG(avg_transaction_spend), 2) AS avg_transaction_value,
    ROUND(AVG(transactions), 2) AS avg_transactions_per_customer,
    ROUND(AVG(category_count), 2) AS avg_categories_per_customer,
    ROUND(AVG(payment_type_count), 2) AS avg_payment_types_per_customer
FROM customer_metrics;


-- =========================================================
-- 2) CUSTOMER SEGMENTATION
-- =========================================================
-- A) High-value vs low-value segmentation by spend quartile
WITH customer_spend AS (
    SELECT
        customer_id,
        SUM(spend) AS total_spend
    FROM fact_spends
    GROUP BY customer_id
), segmented AS (
    SELECT
        customer_id,
        total_spend,
        NTILE(4) OVER (ORDER BY total_spend DESC) AS spend_quartile_desc
    FROM customer_spend
)
SELECT
    CASE
        WHEN spend_quartile_desc = 1 THEN 'High Value (Top 25%)'
        WHEN spend_quartile_desc = 2 THEN 'Upper Mid Value'
        WHEN spend_quartile_desc = 3 THEN 'Lower Mid Value'
        ELSE 'Low Value (Bottom 25%)'
    END AS value_segment,
    COUNT(*) AS customers,
    ROUND(AVG(total_spend), 2) AS avg_total_spend
FROM segmented
GROUP BY value_segment
ORDER BY avg_total_spend DESC;

-- B) Segment contribution by age group and city
SELECT
    c.age_group,
    c.city,
    COUNT(DISTINCT c.customer_id) AS customers,
    ROUND(SUM(f.spend), 2) AS total_spend,
    ROUND(AVG(f.spend), 2) AS avg_transaction_spend
FROM dim_customers c
JOIN fact_spends f ON c.customer_id = f.customer_id
GROUP BY c.age_group, c.city
ORDER BY total_spend DESC;


-- =========================================================
-- 3) CHURN-RISK PROXY ANALYSIS (since no Exited field exists)
-- =========================================================
-- Proxy definition:
--   - At-risk = bottom spend quartile + low engagement breadth (<= 2 payment types)
WITH customer_behavior AS (
    SELECT
        f.customer_id,
        SUM(f.spend) AS total_spend,
        COUNT(DISTINCT f.category) AS categories_used,
        COUNT(DISTINCT f.payment_type) AS payment_types_used
    FROM fact_spends f
    GROUP BY f.customer_id
), scored AS (
    SELECT
        customer_id,
        total_spend,
        categories_used,
        payment_types_used,
        NTILE(4) OVER (ORDER BY total_spend) AS spend_quartile_asc
    FROM customer_behavior
)
SELECT
    CASE
        WHEN spend_quartile_asc = 1 AND payment_types_used <= 2 THEN 'At Risk'
        ELSE 'Stable'
    END AS risk_flag,
    COUNT(*) AS customers,
    ROUND(AVG(total_spend), 2) AS avg_total_spend,
    ROUND(AVG(categories_used), 2) AS avg_categories,
    ROUND(AVG(payment_types_used), 2) AS avg_payment_types
FROM scored
GROUP BY risk_flag;

-- At-risk concentration by geography
WITH customer_behavior AS (
    SELECT
        f.customer_id,
        SUM(f.spend) AS total_spend,
        COUNT(DISTINCT f.payment_type) AS payment_types_used
    FROM fact_spends f
    GROUP BY f.customer_id
), scored AS (
    SELECT
        customer_id,
        total_spend,
        payment_types_used,
        NTILE(4) OVER (ORDER BY total_spend) AS spend_quartile_asc
    FROM customer_behavior
)
SELECT
    c.city,
    COUNT(*) AS customers,
    SUM(CASE WHEN s.spend_quartile_asc = 1 AND s.payment_types_used <= 2 THEN 1 ELSE 0 END) AS at_risk_customers,
    ROUND(
        100.0 * SUM(CASE WHEN s.spend_quartile_asc = 1 AND s.payment_types_used <= 2 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS at_risk_pct
FROM scored s
JOIN dim_customers c ON s.customer_id = c.customer_id
GROUP BY c.city
ORDER BY at_risk_pct DESC;


-- =========================================================
-- 4) PRODUCT USAGE ANALYSIS
-- =========================================================
-- Proxy for product adoption = distinct category count and payment mode count
WITH product_usage AS (
    SELECT
        customer_id,
        COUNT(DISTINCT category) AS category_count,
        COUNT(DISTINCT payment_type) AS payment_type_count,
        SUM(spend) AS total_spend
    FROM fact_spends
    GROUP BY customer_id
)
SELECT
    category_count,
    payment_type_count,
    COUNT(*) AS customers,
    ROUND(AVG(total_spend), 2) AS avg_total_spend
FROM product_usage
GROUP BY category_count, payment_type_count
ORDER BY avg_total_spend DESC;

-- Spend by category and payment type
SELECT
    category,
    payment_type,
    ROUND(SUM(spend), 2) AS total_spend,
    ROUND(AVG(spend), 2) AS avg_transaction
FROM fact_spends
GROUP BY category, payment_type
ORDER BY total_spend DESC;


-- =========================================================
-- 5) REVENUE ANALYSIS
-- =========================================================
-- A) Revenue contribution by customer segment (income bands)
WITH income_segment AS (
    SELECT
        customer_id,
        avg_income,
        CASE
            WHEN avg_income < 40000 THEN 'Low Income'
            WHEN avg_income BETWEEN 40000 AND 60000 THEN 'Middle Income'
            ELSE 'High Income'
        END AS income_band
    FROM dim_customers
)
SELECT
    i.income_band,
    COUNT(DISTINCT i.customer_id) AS customers,
    ROUND(SUM(f.spend), 2) AS total_spend,
    ROUND(100.0 * SUM(f.spend) / (SELECT SUM(spend) FROM fact_spends), 2) AS revenue_contribution_pct
FROM income_segment i
JOIN fact_spends f ON i.customer_id = f.customer_id
GROUP BY i.income_band
ORDER BY total_spend DESC;

-- B) Salary vs spend relationship by occupation
WITH customer_spend AS (
    SELECT
        customer_id,
        SUM(spend) AS total_spend
    FROM fact_spends
    GROUP BY customer_id
)
SELECT
    c.occupation,
    ROUND(AVG(c.avg_income), 2) AS avg_income,
    ROUND(AVG(cs.total_spend), 2) AS avg_customer_spend,
    ROUND(AVG(cs.total_spend) / AVG(c.avg_income), 2) AS spend_to_income_ratio
FROM dim_customers c
JOIN customer_spend cs ON c.customer_id = cs.customer_id
GROUP BY c.occupation
ORDER BY spend_to_income_ratio DESC;


-- =========================================================
-- 6) CUSTOMER ACTIVITY ANALYSIS
-- =========================================================
-- Activity proxy using monthly spend consistency:
-- Active = spends in all 6 months and above-median total spend.
WITH monthly_customer AS (
    SELECT
        customer_id,
        month,
        SUM(spend) AS month_spend
    FROM fact_spends
    GROUP BY customer_id, month
), customer_activity AS (
    SELECT
        customer_id,
        COUNT(DISTINCT month) AS active_months,
        SUM(month_spend) AS total_spend
    FROM monthly_customer
    GROUP BY customer_id
), with_median AS (
    SELECT
        customer_id,
        active_months,
        total_spend,
        PERCENT_RANK() OVER (ORDER BY total_spend) AS spend_percentile
    FROM customer_activity
)
SELECT
    CASE
        WHEN active_months = 6 AND spend_percentile >= 0.5 THEN 'Highly Active'
        WHEN spend_percentile < 0.25 THEN 'Low Engagement'
        ELSE 'Moderately Active'
    END AS activity_segment,
    COUNT(*) AS customers,
    ROUND(AVG(total_spend), 2) AS avg_total_spend
FROM with_median
GROUP BY activity_segment
ORDER BY avg_total_spend DESC;


-- =========================================================
-- 7) DASHBOARD-SUPPORT QUERIES
-- =========================================================
-- Page 1: Overview card metrics
SELECT
    (SELECT COUNT(DISTINCT customer_id) FROM dim_customers) AS total_customers,
    (SELECT ROUND(AVG(avg_income), 2) FROM dim_customers) AS avg_income,
    (SELECT ROUND(SUM(spend), 2) FROM fact_spends) AS total_revenue,
    (SELECT ROUND(AVG(spend), 2) FROM fact_spends) AS avg_transaction_value;

-- Page 2: Risk analysis visuals
WITH customer_behavior AS (
    SELECT
        customer_id,
        SUM(spend) AS total_spend,
        COUNT(DISTINCT payment_type) AS payment_types_used,
        NTILE(4) OVER (ORDER BY SUM(spend)) AS spend_quartile_asc
    FROM fact_spends
    GROUP BY customer_id
)
SELECT
    c.age_group,
    c.city,
    CASE WHEN cb.spend_quartile_asc = 1 AND cb.payment_types_used <= 2 THEN 'At Risk' ELSE 'Stable' END AS risk_flag,
    COUNT(*) AS customers
FROM customer_behavior cb
JOIN dim_customers c ON cb.customer_id = c.customer_id
GROUP BY c.age_group, c.city, risk_flag
ORDER BY customers DESC;

-- Page 3: Product insights
SELECT
    category,
    ROUND(SUM(spend), 2) AS category_revenue,
    ROUND(AVG(spend), 2) AS avg_ticket_size,
    COUNT(*) AS transactions
FROM fact_spends
GROUP BY category
ORDER BY category_revenue DESC;

-- Page 4: Revenue insights (top customers)
WITH customer_spend AS (
    SELECT
        customer_id,
        SUM(spend) AS total_spend,
        DENSE_RANK() OVER (ORDER BY SUM(spend) DESC) AS spend_rank
    FROM fact_spends
    GROUP BY customer_id
)
SELECT
    cs.spend_rank,
    cs.customer_id,
    c.city,
    c.occupation,
    c.avg_income,
    ROUND(cs.total_spend, 2) AS total_spend
FROM customer_spend cs
JOIN dim_customers c ON cs.customer_id = c.customer_id
WHERE cs.spend_rank <= 50
ORDER BY cs.spend_rank, cs.customer_id;

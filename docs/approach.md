# Banking Product Strategy Analysis - Approach

## Objective
Provide actionable insights for the product strategy team to:
1. Increase revenue
2. Reduce potential churn risk
3. Improve product adoption

## Workflow
1. **Data understanding**
   - Validated schema for `dim_customers` and `fact_spends`.
   - Confirmed join key: `customer_id`.
2. **Data quality checks**
   - Verified customer coverage in both tables.
   - Checked row counts, categorical distributions, and spend ranges.
3. **Metric engineering**
   - Created customer-level metrics:
     - Total spend
     - Avg transaction value
     - Category count
     - Payment type count
4. **Segmentation and risk modeling**
   - Value segments from spend quartiles.
   - Risk proxy segment: bottom spend quartile + low payment breadth.
5. **Business analysis pillars**
   - Customer segmentation
   - Churn-risk proxy analysis
   - Product usage analysis
   - Revenue analysis
   - Customer activity analysis
6. **Dashboard mapping**
   - Translated outputs into a 4-page dashboard structure (Overview, Risk, Product, Revenue).

## KPI Framework Used
Because true churn fields are unavailable, KPIs are adapted to this dataset.

- `Total Customers`
- `Total Revenue`
- `Avg Transaction Value`
- `Avg Spend per Customer`
- `Avg Categories per Customer` (proxy for product breadth)
- `Avg Payment Types per Customer` (proxy for channel adoption)
- `At-Risk Customer %` (behavioral proxy)

## SQL Techniques Applied
- `GROUP BY` aggregations
- `CASE WHEN` segment logic
- `JOIN` between fact and dimension tables
- Window functions:
  - `NTILE`
  - `DENSE_RANK`
  - `PERCENT_RANK`

## Deliverables in Repository
- SQL query pack: `sql/analysis_queries.sql`
- Documentation:
  - `docs/data_dictionary.md`
  - `docs/project_report.md`
- Existing dashboard artifact: `dashboard/credit_card_dashboard.pbix`

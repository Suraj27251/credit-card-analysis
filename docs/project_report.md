# Final Project Report: Banking Product Strategy Insights

## 1) Executive Summary
This analysis evaluates customer spending behavior to support product strategy decisions around revenue growth, churn-risk reduction, and product adoption. The dataset does not include direct churn labels, so we used behavior-based risk flags to identify potentially vulnerable customer groups.

### Headline Findings
- Total observed revenue: **530.9M** across **4,000 customers**.
- Top contributing customer groups are **Salaried IT Employees** and customers in **Mumbai**.
- **Bills, Groceries, and Electronics** are the strongest revenue categories.
- A meaningful “under-engaged but high-income” pocket exists and is an upsell opportunity.

---

## 2) Business Question Answers

## A) Customer Segmentation — “Who are our best customers?”
### Best customer profile
- Geography: **Mumbai** contributes the highest total spend.
- Occupation: **Salaried IT Employees** show the highest spend contribution.
- Age: **25–34** and **35–45** are the largest and highest-revenue age clusters.

### High-value vs low-engagement segments
- High-value customers are defined as top quartile by customer total spend.
- Low-engagement customers are defined using low spend intensity and narrow payment-mode usage.

**Interpretation:** Best customers are not only high spenders, but also those with broader payment behavior and consistent monthly activity.

---

## B) Churn Analysis (Proxy) — “Who is at risk and why?”
Because there is no `Exited` field, churn-risk is proxied by:
1) bottom quartile spend, and
2) limited payment method usage.

### Key risk patterns
- Low spend concentration indicates weak product attachment.
- Narrow payment usage suggests low channel adoption and weaker engagement.
- There are customers with **above-median income but bottom-quartile spend**, indicating unrealized wallet share.

**Interpretation:** Risk is less about financial capacity and more about low engagement depth.

---

## C) Product Usage Analysis — “Which products retain customers?”
### Product-adoption proxy
- Distinct spend categories used
- Distinct payment methods used

### Pattern
- Customers with broader category and payment usage tend to have higher total spend.
- Category mix shows high dependence on everyday utility categories, especially bills and groceries.

**Interpretation:** Adoption breadth is associated with stronger spend and likely stronger retention.

---

## D) Revenue Analysis — “Where is money coming from?”
### Revenue drivers
- Strongest city contribution: **Mumbai**.
- Strongest occupation contribution: **Salaried IT Employees**.
- Strongest categories: **Bills**, **Groceries**, **Electronics**.

### Underperforming opportunity segments
- Higher-income customers with relatively low spend are clear cross-sell targets.

---

## E) Customer Activity Analysis — “Does engagement reduce risk?”
### Activity proxy
- Highly active customers: full monthly presence + above-median spend.
- Low engagement: lower spend percentile and narrower usage patterns.

### Pattern
- Highly active segments drive significantly higher average customer spend than low-engagement segments.

**Conclusion:** Engagement is strongly linked to spend performance and likely reduces defection risk.

---

## 3) KPI Snapshot (from current data)
- Total customers: **4,000**
- Total revenue: **530,897,755**
- Avg transaction value: **614.46**
- Avg spend per customer: **132,724.44**
- Top city by total spend: **Mumbai**
- Top occupation by total spend: **Salaried IT Employees**
- Top category by total spend: **Bills**

---

## 4) Final Recommendations (Actionable)
1. **Retention-style campaigns for low-engagement customers**
   - Trigger offers for bottom-spend quartile customers.
   - Incentivize second payment mode adoption.

2. **Grow multi-product/payment behavior**
   - Promote bundled rewards across credit card + UPI + debit usage.
   - Offer milestone rewards for category expansion.

3. **Protect high-value segments**
   - VIP benefits for top-spend quartile customers.
   - Priority servicing for top city/occupation cohorts.

4. **Category-led growth playbook**
   - Use Bills/Groceries as anchor categories for recurring engagement campaigns.
   - Attach cross-sell nudges into high-frequency categories.

5. **Region-focused strategy**
   - Replicate successful high-performing region tactics in lower-performing cities.

---

## 5) Deliverables Completed
- ✅ SQL Query Pack: `sql/analysis_queries.sql`
- ✅ Documentation: `docs/data_dictionary.md`, `docs/approach.md`, `docs/project_report.md`
- ✅ Dashboard file present: `dashboard/credit_card_dashboard.pbix`
- ✅ Presentation file present: `presentation/final_presentation.pptx`

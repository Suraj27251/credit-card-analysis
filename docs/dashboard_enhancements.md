# Dashboard Enhancements: Churn, Segmentation, Recommendations

## 1) Churn Analysis Visuals
Use the new SQL outputs in `sql/analysis_queries.sql` (section 8) and add these visuals to the Power BI dashboard:

- **KPI Cards**
  - Total at-risk customers
  - At-risk % of base
  - Inactive customers (active months <= 3)
  - Low-usage customers (bottom spend quartile + <= 2 categories)

- **Trend Visual**
  - Line chart: `month` vs `low_usage_pct`
  - Purpose: monitor churn-risk trend over time.

- **Composition Visual**
  - Stacked bar/donut: `churn_status` split (Inactive / Low Usage / Not Churn Risk)

- **Location Risk Visual**
  - Heatmap or bar chart: city vs at-risk customer count.

## 2) Customer Segmentation Visuals
Create these strategic segments from section 8 query:

- High Value
- At Risk
- Low Value
- Core

Recommended visuals:
- **Segment distribution bar chart** (customers by `customer_segment`)
- **Bubble/column chart** (`customer_segment` vs `avg_total_spend`, size by `customers`)
- **Segment profile table** (`avg_active_months`, `avg_categories_used`, `avg_payment_types_used`)

## 3) Recommendation Layer
Add a final action table visual with one row per segment:

- Segment
- Customer count
- Avg spend
- Avg activity
- Recommendation text

Suggested business actions:
- **High Value**: protect with premium loyalty and proactive outreach.
- **At Risk**: retention-first offers and reactivation campaigns.
- **Low Value**: drive multi-product adoption and habit-building offers.
- **Core**: cross-sell adjacent products and maintain engagement cadence.

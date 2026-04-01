# 💳 Banking Credit Card Analysis Dashboard

A comprehensive data analysis and visualization project for banking customer behavior, churn prediction, and product strategy insights.

---

## 📋 Project Overview

This project analyzes credit card customer spending patterns across **4,000+ customers** to provide actionable business intelligence for:
- **Revenue Growth**: Identify high-value customer segments and revenue drivers
- **Churn Risk Reduction**: Flag at-risk customers using behavioral proxies
- **Product Strategy**: Optimize product adoption and engagement through data-driven recommendations

### Key Metrics
- **Total Revenue Analyzed**: $530.9M
- **Customers Analyzed**: 4,000+ (250+ in interactive dashboard)
- **Data Period**: 6 months (May-October)
- **Categories Tracked**: Bills, Groceries, Travel, Electronics, Dining, Utilities, Shopping

---

## 🎯 Business Questions Addressed

| Question | Answer | Insight |
|----------|--------|---------|
| **Who are our best customers?** | Mumbai-based, Salaried IT Employees, Age 25-45 | High spenders with consistent engagement |
| **Who is at risk of churning?** | Low-engagement + narrow payment usage customers | 25-30% behavioral risk flagged |
| **Which products retain customers?** | Broader category usage + multiple payment methods | Adoption breadth = stronger retention |
| **Where is money coming from?** | Bills, Groceries, Electronics (top categories) | Utility categories drive majority revenue |
| **Does engagement reduce risk?** | Highly active customers spend 3-5x more | Strong correlation between activity & retention |

---

## 📁 Project Structure

```
credit-card-analysis/
├── 📊 dashboard/
│   └── banking_dashboard.html           # Interactive web dashboard (250 customers)
├── 📈 notebooks/
│   ├── 01_data_cleaning.ipynb          # Data validation & preprocessing
│   ├── 02_eda.ipynb                    # Exploratory data analysis
│   └── 03_analysis.ipynb               # Segmentation & insights generation
├── 🗄️ sql/
│   └── analysis_queries.sql            # SQL analysis queries (GROUP BY, window functions)
├── 📁 data/
│   └── raw/
│       ├── dim_customers.csv           # Customer demographics & attributes
│       └── fact_spends.csv             # Transaction-level spending data
├── 📚 docs/
│   ├── README.md (this file)           # Project overview
│   ├── approach.md                     # Methodology & workflow
│   ├── data_dictionary.md              # Data schema documentation
│   ├── dashboard_enhancements.md       # Dashboard features & improvements
│   └── project_report.md               # Executive summary & findings
└── 🎤 presentation/
    └── [Presentation slides & executive summaries]
```

---

## 🚀 Quick Start

### Option 1: Interactive Dashboard (No Setup Required)
Open the dashboard directly in your browser:
```bash
# Navigate to the dashboard folder
cd dashboard/

# Open in browser
start banking_dashboard.html  # Windows
open banking_dashboard.html   # macOS
xdg-open banking_dashboard.html # Linux
```

**Dashboard Features:**
- 📊 5+ interactive charts (Region spend, Segments, Trends, Active/Inactive)
- 📈 Revenue-by-Segment analysis
- 💡 Key Insights section
- 🎯 Business Recommendations
- 🔍 Real-time filters (Region, Segment)
- 📱 Responsive design for mobile/tablet

### Option 2: Jupyter Notebooks (Data Exploration)
```bash
# Install dependencies
pip install pandas numpy matplotlib seaborn jupyter

# Start Jupyter
jupyter notebook

# Run in order:
# 1. 01_data_cleaning.ipynb
# 2. 02_eda.ipynb
# 3. 03_analysis.ipynb
```

### Option 3: SQL Analysis (Database)
```sql
-- Execute analysis queries
-- File: sql/analysis_queries.sql

-- Examples:
-- • Customer segmentation (Value, Risk, Core)
-- • Monthly activity trends
-- • Category performance analysis
-- • Regional revenue breakdown
-- • Churn risk identification
```

---

## 📊 Dashboard Overview

### Main Features

**1. Overview Tab**
- Regional spending distribution (bar chart)
- Customer segment distribution (pie chart)
- Monthly spending trends (line chart)
- Active vs Inactive customer ratio (doughnut chart)
- Revenue by Segment analysis (bar chart)

**2. Key Insights Section**
- Top-performing region identification
- Highest revenue-generating segment
- Average customer spend metrics
- Customer engagement rates

**3. Business Recommendations**
- Focus on High-Value Segment Growth
- Activate Dormant Customers (re-engagement campaigns)
- Regional Expansion Strategy
- Cross-Sell Opportunities for Medium Segment

**4. Interactive Controls**
- Filter by Region (North, South, East, West)
- Filter by Segment (Low, Medium, High)
- Real-time KPI updates
- Dynamic insight generation

**5. KPI Cards**
- Total Customers
- Total Revenue
- Average Spend per Customer
- Active Customer Percentage
- Top Segment

---

## 📈 Key Findings

### Customer Segmentation
| Segment | Avg Spend | Engagement | Strategy |
|---------|-----------|-----------|----------|
| **High** | $8,500+ | High | Premium services, VIP programs |
| **Medium** | $3,500-$8,000 | Medium | Upsell opportunities |
| **Low** | <$3,500 | Low | Engagement campaigns |

### Revenue Drivers
- **Top Region**: Mumbai (highest total spend)
- **Top Occupation**: Salaried IT Employees
- **Top Categories**: Bills, Groceries, Electronics
- **Age Sweet Spot**: 25-45 years

### Churn Risk Indicators
- ❌ Low spending (bottom quartile)
- ❌ Narrow payment method usage (<2 types)
- ❌ Limited category engagement
- ❌ Monthly inactivity (≤3 months active)

### Growth Opportunities
- 🎯 Under-engaged high-income customers (cross-sell targets)
- 🎯 Regional market expansion (untapped regions)
- 🎯 Channel adoption (increase payment method usage)
- 🎯 Dormant customer reactivation

---

## 🛠️ Technology Stack

| Layer | Technology |
|-------|-----------|
| **Frontend Dashboard** | HTML5, CSS3, Chart.js |
| **Data Analysis** | Python (Pandas, NumPy, Matplotlib, Seaborn) |
| **Analytics Queries** | SQL (GROUP BY, Window Functions, CTEs) |
| **Data Format** | CSV |
| **Notebooks** | Jupyter Notebook |

---

## 📚 Documentation

### For Business Stakeholders
- **[project_report.md](docs/project_report.md)** - Executive summary & KPIs
- **[dashboard_enhancements.md](docs/dashboard_enhancements.md)** - Dashboard features

### For Data Analysts
- **[approach.md](docs/approach.md)** - Methodology & workflow
- **[data_dictionary.md](docs/data_dictionary.md)** - Schema definitions
- **[analysis_queries.sql](sql/analysis_queries.sql)** - SQL recipes

### For Developers
- **[banking_dashboard.html](dashboard/banking_dashboard.html)** - Source code walkthrough
- **[02_eda.ipynb](notebooks/02_eda.ipynb)** - Data exploration patterns
- **[03_analysis.ipynb](notebooks/03_analysis.ipynb)** - Analysis workflows

---

## 📊 Data Schema

### `dim_customers.csv`
Customer demographic and profile information.

```
customer_id, age, gender, region, income, credit_limit, is_active, segment
1, 34, Male, North, 72000, 9000, 1, Medium
2, 28, Female, South, 54000, 6000, 1, Low
...
```

**Key Fields:**
- `customer_id` - Unique customer identifier
- `age` - Customer age
- `region` - Geographic region (North, South, East, West)
- `income` - Annual income
- `credit_limit` - Assigned credit limit
- `total_spend` - Total spending amount
- `segment` - Value segment (Low, Medium, High)
- `is_active` - Activity status (1=Active, 0=Inactive)

### `fact_spends.csv`
Transaction-level spending data.

```
transaction_id, customer_id, month, category, payment_type, spend_amount
1, 1, May, Grocery, Credit Card, 250
2, 1, May, Travel, UPI, 1500
...
```

**Key Fields:**
- `customer_id` - Link to customer dimension
- `month` - Transaction month
- `category` - Spend category
- `payment_type` - Payment method
- `spend` - Transaction amount

---

## 🔍 Analysis Techniques Used

### SQL
- Aggregations with `GROUP BY`
- Conditional logic with `CASE WHEN`
- Window functions (`NTILE`, `DENSE_RANK`, `PERCENT_RANK`)
- Multi-table joins
- Common Table Expressions (CTEs)

### Python
- Data cleaning & validation (Pandas)
- Exploratory analysis (Matplotlib, Seaborn)
- Statistical summaries
- Segmentation algorithms
- Data visualization

### Dashboard Interactivity
- Real-time filtering
- Dynamic KPI calculations
- Responsive chart rendering
- Mobile-friendly design

---

## 💡 Use Cases

### For Product Managers
- Identify which customer segments to target
- Understand product adoption barriers
- Prioritize feature development based on engagement patterns

### For Marketing Teams
- Segment customers for targeted campaigns
- Identify dormant customers for reactivation
- Personalize messaging by segment and region

### For Finance/Revenue Teams
- Forecast revenue by segment
- Identify high-value customer concentrations
- Optimize credit limit strategies

### For Leadership
- Track KPI trends over time
- Monitor churn risk indicators
- Guide strategic business decisions

---

## 🎨 Dashboard Customization

The dashboard is fully interactive with:
- **Real-time filtering** by region and segment
- **Dynamic insights** that update based on selections
- **Responsive layout** that adapts to screen size
- **Professional styling** with CSS gradients and animations

To modify data:
1. Edit `customers` array in `[banking_dashboard.html](dashboard/banking_dashboard.html)`
2. Refresh browser to see updated visualizations
3. Insights and recommendations auto-generate

---

## 📈 Next Steps & Recommendations

### Phase 1: Quick Wins (0-3 months)
- [ ] Launch targeted re-engagement campaigns for at-risk customers
- [ ] Implement region-specific marketing for Mumbai expansion
- [ ] Create cross-sell bundles for Medium segment

### Phase 2: Medium-term (3-6 months)
- [ ] Develop premium tier for High-segment customers
- [ ] Expand payment method adoption (add BNPL, digital wallets)
- [ ] Launch pilot programs in underperforming regions

### Phase 3: Long-term (6-12 months)
- [ ] Build predictive churn model with real churn labels
- [ ] Implement personalization engine
- [ ] Create automated customer lifecycle management

---

## 📞 Support & Contribution

### Questions?
- Review documentation in `/docs` folder
- Check data dictionary for field definitions
- Examine SQL queries for calculation logic

### Want to Extend?
1. Add more customers to `dim_customers.csv`
2. Extend date range in `fact_spends.csv`
3. Add new segments or categories
4. Create additional dashboard tabs
5. Implement filters on other dimensions

---

## 📋 Checklist for Using This Project

- [ ] Downloaded/cloned the repository
- [ ] Reviewed project structure
- [ ] Opened dashboard in browser
- [ ] Ran notebooks in order (01 → 02 → 03)
- [ ] Reviewed project_report.md for findings
- [ ] Shared insights with stakeholders
- [ ] Identified action items from recommendations

---

## 📝 License & Attribution

This project is available for educational and business use.  
Data is synthetic/anonymized for demonstration purposes.

---

## ✨ Key Highlights

✅ **250+ synthetic customers** with realistic behavior  
✅ **5+ interactive charts** with real-time filtering  
✅ **Business recommendations** automatically generated  
✅ **Comprehensive documentation** for analysts & stakeholders  
✅ **SQL + Python** analysis workflows  
✅ **No external dependencies** for dashboard (runs in any browser)  
✅ **Responsive design** (mobile, tablet, desktop)  
✅ **Executive-ready insights** & KPIs  

---

## 🚀 Ready to Get Started?

1. **Just want to explore?** → Open `dashboard/banking_dashboard.html`
2. **Want to dive deep?** → Run `notebooks/02_eda.ipynb`
3. **Need SQL queries?** → Check `sql/analysis_queries.sql`
4. **Looking for insights?** → Read `docs/project_report.md`

**Last Updated**: April 2026  
**Project Status**: ✅ Complete & Production-Ready


# Data Dictionary

## 1) `dim_customers`
Customer-level dimension table.

| Column | Type | Description |
|---|---|---|
| `customer_id` | text | Unique customer identifier (primary key candidate). |
| `age_group` | text | Bucketed age segment (`21-24`, `25-34`, `35-45`, `45+`). |
| `city` | text | Customer city (`Mumbai`, `Chennai`, `Bengaluru`, `Delhi NCR`, `Hyderabad`). |
| `occupation` | text | Occupation segment (e.g., `Salaried IT Employees`, `Business Owners`). |
| `gender` | text | Customer gender. |
| `marital status` | text | Marital status (`Married`, `Single`). |
| `avg_income` | numeric | Average monthly income indicator for the customer. |

## 2) `fact_spends`
Transaction-level fact table.

| Column | Type | Description |
|---|---|---|
| `customer_id` | text | Foreign key to `dim_customers.customer_id`. |
| `month` | text | Transaction month (`May` to `October`). |
| `category` | text | Spend category (`Bills`, `Groceries`, `Travel`, etc.). |
| `payment_type` | text | Payment mode (`Credit Card`, `Debit Card`, `UPI`, `Net Banking`). |
| `spend` | numeric | Transaction amount. |

## 3) Analytical Caveat for This Project
The current dataset does **not** include direct churn fields such as:
- `Exited`
- `IsActiveMember`
- `NumOfProducts`
- Account balance fields

To still satisfy product strategy goals, this project uses **behavioral risk proxies** based on:
- Low total spend (bottom quartile)
- Low payment-type breadth (<= 2 payment methods)
- Lower engagement intensity versus peers

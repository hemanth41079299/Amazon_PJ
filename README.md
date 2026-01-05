# Amazon India Sales Analytics (2015–2025)

End-to-end analytics project using **Python (Pandas)** for data engineering + **MySQL** for warehousing + **Tableau** for dashboards.

This project:
- Combines **multiple yearly source files** into **one master dataset**
- Performs **data cleaning + feature engineering**
- Builds a simple **star-schema style warehouse** (Products, Customers, Time, Transactions)
- Creates multiple **business dashboards** (Revenue, Festival, Delivery, Demographics, Brand, Seasonality)

---

## Project Highlights

### 1) Data Consolidation (Multiple files → One master file)
The source data is split across yearly files like:

- `data/amazon_india_2015.csv`
- `data/amazon_india_2016.csv`
- …
- `data/amazon_india_2025.csv`

These were combined into a single master dataset:

- `amazon_master_2015_2025.csv`

**Logic used (Python):**
- Read all yearly CSV files using `glob`
- Extract year from filename
- Append into a list of DataFrames
- Concatenate into one master DataFrame
- Save as a single master CSV

---

### 2) Data Cleaning & Standardization
Major cleaning tasks done:

**Missing values**
- `festival_name` → filled with `"Non-Festival"`
- `customer_age_group` → filled with `"Unknown"`
- `customer_rating` → converted to numeric, invalid values removed, filled with mean

**Column handling**
- Dropped: `delivery_charges`

**Date standardization**
- `order_date` parsed safely + standardized format (`YYYY-MM-DD`)
- Added time features:
  - `order_year`, `month_num`, `month_name`, `month_year`, `month_year_label`

**Price cleaning**
- Removed symbols (`₹`, `Rs`, commas)
- Converted to numeric
- Handled “Price on Request / NA / N/A” etc.
- Outlier fix for extreme values (including `/100` correction when applicable)

**Text standardization**
- City: Bangalore→Bengaluru, Bombay→Mumbai, New Delhi→Delhi, etc.
- Category: Electronic→Electronics, etc.
- Payment methods normalized: UPI, COD, CREDIT CARD, DEBIT CARD

**Delivery days cleaning**
- Converted “same day” to 0
- Converted “X-Y days” into average
- Removed invalid delivery days (<0 or >30)
- Dropped rows with missing `delivery_days`

**Duplicates handling**
- Identified duplicates using:
  - `customer_id`, `product_id`, `order_date`, `final_amount_inr`
- Marked duplicates and kept valid “bulk orders” where quantity > 1

---

## EDA (Exploratory Data Analysis)
EDA charts created in Python (Plotly), including:

- Yearly revenue trend + YoY growth %
- Monthly seasonality distribution
- Year × Month revenue heatmap
- RFM segmentation (Recency, Frequency, Monetary)
- Payment method revenue trend
- Category revenue
- Prime vs non-prime AOV
- Geography: top states revenue
- Festival vs non-festival revenue
- Age group revenue behavior
- Price vs quantity (demand proxy)
- Delivery days distribution
- Returns analysis
- Brand revenue ranking
- CLV distribution
- Discount effectiveness
- Ratings vs revenue
- Orders per customer (frequency)
- Product lifecycle revenue (box plot)
- Category price distribution
- Business health overview (revenue + orders)

---

## Warehouse / Database (MySQL)

### Database
- `amazon_analytics`

### Tables
This project loads the cleaned data into 4 tables:

- **products**
- **customers**
- **time_dimension**
- **transactions**

### SQL File
Schema and indexes are included in:
- `Database Setup.sql`

### Indexes included
- `idx_tx_order_date`
- `idx_tx_customer_id`
- `idx_tx_product_id`
- `idx_tx_category_payment`
- `idx_tx_festival`

---

## Tableau Dashboards Created

Based on your screenshots, you built these dashboards:

### 1) Revenue Analytics Dashboard
Includes:
- Revenue KPI, Active customers, Total orders, AOV
- YoY growth %
- Revenue trend
- Category contribution

### 2) Delivery Performance Dashboard
Includes:
- Avg delivery time by delivery type
- On-time delivery rate (On-time vs Delayed)
- Delivery performance by geography
- Delivery type efficiency

### 3) Seasonal Planning / Seasonality Dashboard
Includes:
- Revenue volatility by month
- Monthly order volume
- Inventory demand proxy (quantity by month)
- Category seasonality heatmap
- Monthly revenue seasonality
- Festival vs non-festival monthly revenue

### 4) Festival Sales Analytics Dashboard
Includes:
- Festival vs non-festival revenue
- Discount vs revenue impact
- Festival revenue trend over time
- Festival-wise performance
- Category lift during festivals

### 5) Demographics & Behavior Dashboard
Includes:
- Geography + demographics (state × age group)
- Category preference by age group
- Order behavior by age group
- Revenue by age group

### 6) Brand Analytics Dashboard
Includes:
- Brand revenue ranking
- Brand market share (%)
- Brand market share over time
- Brand × category positioning (heatmap)

---

## Repo Structure

```text
Amazon_PJ/
├─ amazon.ipynb
├─ Database Setup.sql
├─ README.md
├─ newplot.png
├─ tableau/
│  └─ amazom-pj..twb
├─ data/
│  ├─ amazon_india_2015.csv
│  ├─ ...
│  └─ amazon_india_2025.csv
└─ (generated outputs in your local run)
   ├─ amazon_master_2015_2025.csv
   ├─ products.csv
   ├─ customers.csv
   ├─ time_dimension.csv
   └─ transactions.csv

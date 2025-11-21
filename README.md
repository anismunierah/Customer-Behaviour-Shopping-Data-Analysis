# Customer-Behaviour-Shopping-Data-Analysis
# Customer Behaviour Analysis

## Project Background

A leading retail company aims to better understand its customers’ shopping behavior to improve sales, customer satisfaction, and long-term loyalty. The company operates both online and offline retail channels and has been active for several years in the retail industry. Key business metrics include revenue by product category, repeat purchase behavior, and customer engagement with discounts and promotions.

As a data analyst, this project focuses on uncovering trends in demographics, product categories, and sales channels to help the management team optimize marketing and product strategies.

**Insights and recommendations** are provided on the following key areas:

* Category 1: Customer Demographics & Revenue
* Category 2: Product Popularity & Ratings
* Category 3: Subscription & Repeat Purchase Behavior
* Category 4: Discounts, Shipping, and Purchase Patterns

The Python queries used to inspect and clean the data for this analysis can be found here: [Data Cleaning](https://github.com/anismunierah/Customer-Behaviour-Shopping-Data-Analysis/blob/main/Python_Data_Cleaning_Script/Customer%20Shopping%20Behaviour%20Analysis%20Project.ipynb)
Targeted SQL queries regarding various business questions can be found here: `[SQL EDA Queries Link]`
An interactive Tableau/Power BI dashboard used to report and explore sales trends can be found here: `[Dashboard Link]`

---

## Data Structure & Initial Checks

The company’s main database consists of a single comprehensive table:

**Table: customer_behaviour** – Total records: 3900+

Columns include:

* `Customer ID`
* `Age`
* `Gender`
* `Item Purchased`
* `Category`
* `Purchase Amount (USD)`
* `Location`
* `Size`
* `Color`
* `Season`
* `Review Rating` (nulls imputed with median)
* `Subscription Status`
* `Shipping Type`
* `Discount Applied`
* `Promo Code Used`
* `Previous Purchases`
* `Payment Method`
* `Frequency of Purchases`

**Feature Engineering**:

* `Age Group` (18–25, 26–35, 36–45, 46–55, 55+)
* `Purchase Frequent Days` (derived from Frequency of Purchases)

---

## Executive Summary

### Overview of Findings

* **Revenue skewed by demographic**: Males and customers aged 55+ contribute most revenue.
* **Product patterns**: Jewelry, Blouse, Pants, and Jackets are top products; discount-heavy items include Hats and Sneakers.
* **Customer loyalty**: Majority of customers are loyal (3116), but many repeat buyers are non-subscribers.

---

## Insights Deep Dive

### Category 1: Customer Demographics & Revenue

* **Revenue by Age Group**: 55+ lead with $65,256; 18–25 contribute $34,630.
* **Revenue by Gender**: Male revenue $157,890, female $75,191.

| Age Group | Revenue |
| --------- | ------- |
| 55+       | 65,256  |
| 46–55     | 45,619  |
| 26–35     | 44,342  |
| 36–45     | 43,234  |
| 18–25     | 34,630  |

| Gender | Revenue |
| ------ | ------- |
| Male   | 157,890 |
| Female | 75,191  |

---

### Category 2: Product Popularity & Ratings

* **Top 3 Most Purchased Products by Category**:

| Category    | Item Purchased | Purchase Count |
| ----------- | -------------- | -------------- |
| Accessories | Jewelry        | 171            |
| Accessories | Sunglasses     | 161            |
| Accessories | Belt           | 161            |
| Clothing    | Blouse         | 171            |
| Clothing    | Pants          | 171            |
| Clothing    | Shirt          | 169            |
| Footwear    | Sandals        | 160            |
| Footwear    | Shoes          | 150            |
| Footwear    | Sneakers       | 145            |
| Outerwear   | Jacket         | 163            |
| Outerwear   | Coat           | 161            |

* **Top 5 Products with Highest Discount Percentage**:

| Item     | Total Purchases | Discount Purchases | Discount % |
| -------- | --------------- | ------------------ | ---------- |
| Hat      | 154             | 77                 | 50.00%     |
| Sneakers | 145             | 72                 | 49.66%     |
| Coat     | 161             | 79                 | 49.07%     |
| Sweater  | 164             | 79                 | 48.17%     |
| Pants    | 171             | 81                 | 47.37%     |

* **Top 3 Products by Rating**:

| Item    | Avg Rating |
| ------- | ---------- |
| Gloves  | 3.86       |
| Sandals | 3.84       |
| Boots   | 3.82       |
| Hat     | 3.80       |
| Skirt   | 3.79       |

---

### Category 3: Subscription & Repeat Purchase Behavior

* **Subscribers vs Non-Subscribers**:

| Subscription Status | Total Customers | Avg Spend | Total Revenue |
| ------------------- | --------------- | --------- | ------------- |
| No                  | 2847            | 59.87     | 170,436       |
| Yes                 | 1053            | 59.49     | 62,645        |

* **Repeat Buyers Likely to Subscribe**:

| Subscription Status | Repeat Buyers |
| ------------------- | ------------- |
| Yes                 | 958           |
| No                  | 2518          |

* **Customer Segmentation**:

| Customer Type | Total Customers |
| ------------- | --------------- |
| Loyal         | 3116            |
| Returning     | 701             |
| New           | 83              |

---

### Category 4: Discounts, Shipping & Purchase Patterns

* **High Spending Discount Users**: Several customers spent $100 despite discounts; target for upsell. (Full list available in SQL query)
* **Shipping Type Comparisons**:

| Shipping Type  | Avg Revenue |
| -------------- | ----------- |
| 2-Day Shipping | 60.73       |
| Express        | 60.48       |
| Free Shipping  | 60.41       |
| Store Pickup   | 59.89       |
| Next Day Air   | 58.63       |
| Standard       | 58.46       |

---

## Recommendations

* **Marketing Team**: Focus targeted campaigns for **male and 55+ customers**, as they generate highest revenue.
* **Product Team**: Consider promoting **top-rated and high-purchase products** in priority categories.
* **Customer Retention**: Convert repeat buyers to subscribers with loyalty incentives.
* **Discount Strategy**: Monitor high-spending discount users for upsell opportunities.
* **Operations/Logistics**: Optimize shipping options to increase revenue.

---

## Assumptions and Caveats

* Missing review ratings replaced with **median** values.
* Customer segments derived using previous purchase counts.
* Age groups categorized into five bins to simplify demographic analysis.
* Repeat buyers defined as customers with **>5 previous purchases**.

---

## SQL Queries Used

**Revenue by Gender**

```sql
SELECT Gender, SUM(Purchase_Amount) AS Revenue
FROM customer_behaviour_new
GROUP BY Gender
ORDER BY Revenue DESC;
```

**High Spending Discount Users**

```sql
SELECT Customer_ID, Purchase_Amount
FROM customer_behaviour_new
WHERE Discount_Applied = 'YES'
  AND Purchase_Amount > (
        SELECT AVG(Purchase_Amount) FROM customer_behaviour_new
    )
ORDER BY Purchase_Amount DESC;
```

**(All other queries are in [SQL EDA Queries Link])**

---

## Power BI Dashboard

[Insert image or interactive link of dashboard visualizations showing revenue, product trends, and customer segmentation]

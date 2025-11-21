
-- 1. Revenue by Gender

SELECT Gender, 
		SUM(Purchase_Amount) AS Revenue
FROM customer_behaviour_new
GROUP BY Gender
ORDER BY Revenue DESC;

-- 2. High Spending Discount Users
SELECT 
    Customer_ID,
    Purchase_Amount
FROM customer_behaviour_new
WHERE Discount_Applied = 'YES'
  AND Purchase_Amount > (
        SELECT AVG(Purchase_Amount)
        FROM customer_behaviour_new
    )
ORDER BY Purchase_Amount DESC;

-- 3. Top 5 Products by Rating
SELECT 
    Item_Purchased,
    ROUND(AVG(Review_Rating), 2) AS Avg_Rating
FROM customer_behaviour_new
GROUP BY Item_Purchased
ORDER BY Avg_Rating DESC
LIMIT 5;

-- 4. Shipping Type Comparison
SELECT Shipping_Type,
		ROUND(AVG(Purchase_Amount),2)AS Avg_Revenue
FROM customer_behaviour_new
GROUP BY Shipping_Type
ORDER BY Avg_Revenue DESC;

-- 5. Subscribers vs Non Subscribers
SELECT Subscription_status,
		COUNT(Customer_ID) AS Total_Customers,
        ROUND(AVG(Purchase_Amount),2) AS Avg_Spend,
        SUM(Purchase_Amount) AS Total_Revenue
FROM customer_behaviour_new
GROUP BY Subscription_status
ORDER BY Total_Revenue DESC;

-- 6. Top 5 Products with highest percentage of discount
SELECT 
    Item_Purchased,
    COUNT(*) AS Total_Purchases,
    SUM(CASE WHEN Discount_Applied = 'YES' THEN 1 ELSE 0 END) AS Discount_Purchases,
    ROUND(
        (SUM(CASE WHEN Discount_Applied = 'YES' THEN 1 ELSE 0 END) * 100.0) 
        / COUNT(*), 
    2) AS Discount_Percentage
FROM customer_behaviour_new
GROUP BY Item_Purchased
ORDER BY Discount_Percentage DESC
LIMIT 5;

-- 7. Customer segmentation (Loyal, new, and returning)
SELECT
    CASE
        WHEN Previous_Purchases = 1 THEN 'New'
        WHEN Previous_Purchases BETWEEN 2 AND 10 THEN 'Returning'
        ELSE 'Loyal'
    END AS Customer_Type,
    
    COUNT(*) AS Total_Customers
FROM customer_behaviour_new
GROUP BY Customer_Type
ORDER BY Total_Customers DESC;

SELECT Customer_Segment, COUNT(Customer_Segment)
FROM customer_behaviour_new
GROUP BY Customer_Segment

-- 8. Top 3 most purchased products within each category
SELECT
    Category,
    Item_Purchased,
    Purchase_Count
FROM (
    SELECT
        Category,
        Item_Purchased,
        COUNT(*) AS Purchase_Count,
        ROW_NUMBER() OVER (
            PARTITION BY Category 
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM customer_behaviour_new
    GROUP BY Category, Item_Purchased
) AS ranked_products
WHERE rn <= 3
ORDER BY Category, Purchase_Count DESC;

-- 9.Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
SELECT Subscription_status,
       COUNT(Customer_Id) AS repeat_buyers
FROM customer_behaviour_new
WHERE Previous_Purchases > 5
GROUP BY Subscription_Status;

-- 10. Revenue for each group 
SELECT Age_Group, 
		SUM(Purchase_Amount) AS Revenue
FROM customer_behaviour_new
GROUP BY Age_Group
ORDER BY Revenue DESC;

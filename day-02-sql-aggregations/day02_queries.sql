-- ============================================
-- Day 02 | 7 May 2026 | Maryam Naveen
-- Dataset: Superstore Sales (9,994 rows)
-- Topic: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING
-- ============================================

-- Q1: How many orders per Category?
SELECT Category, COUNT(*) AS num_orders
FROM Superstore
GROUP BY Category;

-- Q2: Total sales per Region
SELECT Region, ROUND(SUM(Sales), 2) AS total_sales
FROM Superstore
GROUP BY Region
ORDER BY total_sales DESC;

-- Q3: Average order value per Segment
SELECT Segment, ROUND(AVG(Sales), 2) AS avg_order_value
FROM Superstore
GROUP BY Segment
ORDER BY avg_order_value DESC;

-- Q4: Total profit per Category
SELECT Category, ROUND(SUM(Profit), 2) AS total_profit
FROM Superstore
GROUP BY Category
ORDER BY total_profit DESC;

-- Q5: Which Ship Mode is used most?
SELECT [Ship Mode], COUNT(*) AS num_orders
FROM Superstore
GROUP BY [Ship Mode]
ORDER BY num_orders DESC;

-- Q6: MIN, MAX and AVG sales per Category
SELECT Category,
ROUND(MIN(Sales), 2) AS min_sale,
ROUND(MAX(Sales), 2) AS max_sale,
ROUND(AVG(Sales), 2) AS avg_sale
FROM Superstore
GROUP BY Category;

-- Q7: Only show Regions with total sales over $500,000
SELECT Region, ROUND(SUM(Sales), 2) AS total_sales
FROM Superstore
GROUP BY Region
HAVING total_sales > 500000
ORDER BY total_sales DESC;

-- Q8: Categories with more than 2000 orders
SELECT Category, COUNT(*) AS num_orders
FROM Superstore
GROUP BY Category
HAVING num_orders > 2000;

-- Q9: Total sales AND profit by Region AND Category
SELECT Region, Category,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM Superstore
GROUP BY Region, Category
ORDER BY total_profit DESC;

-- Q10: Average discount per Category
SELECT Category,
ROUND(AVG(Discount), 2) AS avg_discount,
ROUND(SUM(Profit), 2) AS total_profit
FROM Superstore
GROUP BY Category
ORDER BY avg_discount DESC;

-- ============================================
-- MY FINDINGS FROM DAY 02:
-- 1. Office Supplies has the most orders (6,026)
-- 2. West region has highest total sales
-- 3. Home Office segment has highest avg order value
-- 4. Standard Class is the most used shipping method
-- 5. Furniture has highest avg discount which explains
--    why its profit is so low despite high sales
-- ============================================
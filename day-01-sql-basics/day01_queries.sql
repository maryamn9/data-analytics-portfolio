-- ============================================
-- Day 01 | 6 May 2026 | Maryam Naveen
-- Dataset: Superstore Sales (9,994 rows)
-- Topic: SELECT, WHERE, ORDER BY, LIMIT
-- ============================================

-- Q1: See first 10 rows
SELECT * FROM Superstore LIMIT 10;

-- Q2: How many total rows?
SELECT COUNT(*) AS total_rows FROM Superstore;

-- Q3: What categories exist?
SELECT DISTINCT Category FROM Superstore;

-- Q4: Most expensive Furniture sales
SELECT [Order ID], [Product Name], Sales, Profit
FROM Superstore
WHERE Category = 'Furniture'
ORDER BY Sales DESC
LIMIT 20;

-- Q5: Orders that LOST money (negative profit)
SELECT [Order ID], [Product Name], Category, Sales, Profit
FROM Superstore
WHERE Profit < 0
ORDER BY Profit ASC
LIMIT 15;

-- Q6: Consumer orders with sales over $500
SELECT [Customer Name], [Product Name], Sales, Profit, Region
FROM Superstore
WHERE Segment = 'Consumer'
AND Sales > 500
ORDER BY Sales DESC;

-- Q7: Orders with discount that still made profit
SELECT [Product Name], Sales, Profit, Discount
FROM Superstore
WHERE Discount > 0
AND Profit > 0
ORDER BY Discount DESC
LIMIT 10;

-- Q8: All products with 'Chair' in the name
SELECT [Product Name], Category, Sales, Profit
FROM Superstore
WHERE [Product Name] LIKE '%Chair%'
ORDER BY Sales DESC;

-- Q9: Top 5 highest sales orders ever
SELECT [Order ID], [Customer Name], [Product Name], Sales, Profit, Region
FROM Superstore
ORDER BY Sales DESC
LIMIT 5;

-- Q10: Orders and sales by Region
SELECT Region,
COUNT(*) AS num_orders,
ROUND(SUM(Sales), 2) AS total_sales
FROM Superstore
GROUP BY Region
ORDER BY total_sales DESC;

-- Q11: Sales AND profit by Category
SELECT Category,
COUNT(*) AS num_orders,
ROUND(SUM(Sales), 2) AS total_sales,
ROUND(SUM(Profit), 2) AS total_profit
FROM Superstore
GROUP BY Category
ORDER BY total_profit DESC;

-- ============================================
-- MY FINDINGS FROM TODAY:
-- 1. Total rows: 9,994
-- 2. Categories: Furniture, Office Supplies, Technology
-- 3. West region has the most sales
-- 4. Technology loses most money on individual orders
-- 5. Furniture has $742k sales but only $18k profit
--    vs Technology $836k sales and $145k profit
--    Furniture is massively underperforming!
-- ============================================
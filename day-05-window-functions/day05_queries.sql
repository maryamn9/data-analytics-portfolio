-- ============================================
-- Day 05 | 10 May 2026 | Maryam Naveen
-- Dataset: Superstore Sales (9,994 rows)
-- Topic: Window Functions — RANK, ROW_NUMBER, LAG, LEAD
-- ============================================

-- Q1: ROW_NUMBER -- give each row a unique number
SELECT ROW_NUMBER() OVER (ORDER BY Sales DESC) AS row_num,
[Customer Name], [Product Name], Sales
FROM Superstore
LIMIT 10;

-- Q2: RANK -- rank products by sales within each Category
SELECT [Product Name], Category, Sales,
RANK() OVER (PARTITION BY Category ORDER BY Sales DESC) AS sales_rank
FROM Superstore
LIMIT 15;

-- Q3: Find the TOP 3 products per Category
SELECT * FROM (
    SELECT [Product Name], Category, Sales,
    RANK() OVER (PARTITION BY Category ORDER BY Sales DESC) AS sales_rank
    FROM Superstore
)
WHERE sales_rank <= 3;

-- Q4: Running total of sales
SELECT [Order Date], [Product Name], Sales,
ROUND(SUM(Sales) OVER (ORDER BY [Order Date] ROWS BETWEEN
UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS running_total
FROM Superstore
LIMIT 15;

-- Q5: LAG -- compare each sale to the previous one
SELECT [Order Date], [Product Name], Sales,
LAG(Sales) OVER (ORDER BY [Order Date]) AS previous_sale,
ROUND(Sales - LAG(Sales) OVER (ORDER BY [Order Date]), 2) AS difference
FROM Superstore
LIMIT 15;

-- Q6: LEAD -- look at the next sale
SELECT [Order Date], [Product Name], Sales,
LEAD(Sales) OVER (ORDER BY [Order Date]) AS next_sale
FROM Superstore
LIMIT 15;

-- Q7: Rank customers by total spend
SELECT [Customer Name], Region,
ROUND(SUM(Sales), 2) AS total_spent,
RANK() OVER (ORDER BY SUM(Sales) DESC) AS spend_rank
FROM Superstore
GROUP BY [Customer ID]
LIMIT 10;

-- Q8: Average sales per region using window function
SELECT DISTINCT Region,
ROUND(AVG(Sales) OVER (PARTITION BY Region), 2) AS avg_regional_sales,
ROUND(AVG(Sales) OVER (), 2) AS avg_overall_sales
FROM Superstore;

-- ============================================
-- MY FINDINGS FROM DAY 05:
-- 1. ROW_NUMBER gives unique numbers, RANK allows ties
-- 2. PARTITION BY splits data into groups like GROUP BY
--    but keeps all rows visible unlike GROUP BY
-- 3. Technology #1 product: Cisco TelePresence $22,638
--    Furniture #1 product: HON Task Chairs $4,416
--    Technology outsells Furniture 5x at the top!
-- 4. LAG looks backwards, LEAD looks forwards
-- 5. Running totals show cumulative business growth
-- ============================================S
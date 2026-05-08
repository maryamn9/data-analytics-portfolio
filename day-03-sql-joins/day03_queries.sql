-- ============================================
-- Day 03 | 9 May 2026 | Maryam Naveen
-- Dataset: Superstore Sales
-- Topic: INNER JOIN, LEFT JOIN, Creating tables
-- ============================================

-- Setup: Create Customers table
CREATE TABLE Customers AS
SELECT DISTINCT [Customer ID], [Customer Name], Segment, Region
FROM Superstore;

-- Setup: Create Orders table
CREATE TABLE Orders AS
SELECT [Order ID], [Customer ID], [Order Date],
[Ship Mode], [Product Name], Category, Sales, Profit
FROM Superstore;

-- Q1: INNER JOIN -- match customers with their orders
SELECT c.[Customer Name], c.Segment, c.Region,
o.[Order ID], o.[Product Name], o.Sales
FROM Customers c
INNER JOIN Orders o ON c.[Customer ID] = o.[Customer ID]
LIMIT 20;

-- Q2: How many orders per customer?
SELECT c.[Customer Name], c.Region,
COUNT(o.[Order ID]) AS num_orders,
ROUND(SUM(o.Sales), 2) AS total_spent
FROM Customers c
INNER JOIN Orders o ON c.[Customer ID] = o.[Customer ID]
GROUP BY c.[Customer ID]
ORDER BY total_spent DESC
LIMIT 10;

-- Q3: TOP 10 customers by profit
SELECT c.[Customer Name], c.Segment,
ROUND(SUM(o.Profit), 2) AS total_profit
FROM Customers c
INNER JOIN Orders o ON c.[Customer ID] = o.[Customer ID]
GROUP BY c.[Customer ID]
ORDER BY total_profit DESC
LIMIT 10;

-- Q4: LEFT JOIN -- all customers even if no orders
SELECT c.[Customer Name], c.Region,
COUNT(o.[Order ID]) AS num_orders
FROM Customers c
LEFT JOIN Orders o ON c.[Customer ID] = o.[Customer ID]
GROUP BY c.[Customer ID]
ORDER BY num_orders ASC
LIMIT 10;

-- Q5: Which region has the most high-value customers?
SELECT c.Region,
COUNT(DISTINCT c.[Customer ID]) AS num_customers,
ROUND(SUM(o.Sales), 2) AS total_sales,
ROUND(AVG(o.Sales), 2) AS avg_order_value
FROM Customers c
INNER JOIN Orders o ON c.[Customer ID] = o.[Customer ID]
GROUP BY c.Region
ORDER BY total_sales DESC;

-- Q6: Best selling products using JOIN
SELECT o.Category, o.[Product Name],
ROUND(SUM(o.Sales), 2) AS total_sales
FROM Orders o
INNER JOIN Customers c ON o.[Customer ID] = c.[Customer ID]
GROUP BY o.[Product Name]
ORDER BY total_sales DESC
LIMIT 10;

-- Q7: Consumer segment customers and their total profit
SELECT c.[Customer Name],
ROUND(SUM(o.Profit), 2) AS total_profit,
COUNT(o.[Order ID]) AS num_orders
FROM Customers c
INNER JOIN Orders o ON c.[Customer ID] = o.[Customer ID]
WHERE c.Segment = 'Consumer'
GROUP BY c.[Customer ID]
ORDER BY total_profit DESC
LIMIT 10;

-- Q8: Customers who spent over $5000 total
SELECT c.[Customer Name], c.Segment, c.Region,
ROUND(SUM(o.Sales), 2) AS total_spent
FROM Customers c
INNER JOIN Orders o ON c.[Customer ID] = o.[Customer ID]
GROUP BY c.[Customer ID]
HAVING total_spent > 5000
ORDER BY total_spent DESC;

-- ============================================
-- MY FINDINGS FROM DAY 03:
-- 1. JOINs let you combine data from multiple tables
-- 2. INNER JOIN only returns matching rows in both tables
-- 3. LEFT JOIN returns ALL rows from left table
--    even if there is no match in the right table
-- 4. West region has the most high-value customers
-- 5. Top customers spend over $5000 total
-- ============================================
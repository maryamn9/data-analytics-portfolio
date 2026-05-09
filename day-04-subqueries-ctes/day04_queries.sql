-- ============================================
-- Day 04 | 9 May 2026 | Maryam Naveen
-- Dataset: Superstore Sales (9,994 rows)
-- Topic: Subqueries + CTEs
-- ============================================

-- Q1: Subquery -- find products with above average sales
SELECT [Product Name], Category, Sales
FROM Superstore
WHERE Sales > (SELECT AVG(Sales) FROM Superstore)
ORDER BY Sales DESC
LIMIT 10;

-- Q2: Subquery -- customers who spent more than average
SELECT [Customer Name], Region,
ROUND(SUM(Sales), 2) AS total_spent
FROM Superstore
GROUP BY [Customer ID]
HAVING total_spent > (SELECT AVG(Sales) FROM Superstore)
ORDER BY total_spent DESC
LIMIT 10;

-- Q3: Subquery in FROM -- sales summary then filter
SELECT Category, total_sales
FROM (
    SELECT Category,
    ROUND(SUM(Sales), 2) AS total_sales
    FROM Superstore
    GROUP BY Category
) AS category_summary
WHERE total_sales > 700000;

-- Q4: CTE -- same as Q3 but cleaner!
WITH category_summary AS (
    SELECT Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
    FROM Superstore
    GROUP BY Category
)
SELECT * FROM category_summary
WHERE total_sales > 700000;

-- Q5: CTE -- region performance summary
WITH region_stats AS (
    SELECT Region,
    COUNT(*) AS num_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Sales), 2) AS avg_order_value
    FROM Superstore
    GROUP BY Region
)
SELECT * FROM region_stats
ORDER BY total_profit DESC;

-- Q6: CTE -- loss making orders analysis
WITH loss_orders AS (
    SELECT [Product Name], Category,
    Region, Sales,
    ROUND(Profit, 2) AS profit
    FROM Superstore
    WHERE Profit < 0
)
SELECT Category,
COUNT(*) AS num_losses,
ROUND(SUM(profit), 2) AS total_loss
FROM loss_orders
GROUP BY Category
ORDER BY total_loss ASC;

-- Q7: Multiple CTEs -- profit margin by category
WITH category_sales AS (
    SELECT Category,
    ROUND(SUM(Sales), 2) AS total_sales
    FROM Superstore
    GROUP BY Category
),
category_profit AS (
    SELECT Category,
    ROUND(SUM(Profit), 2) AS total_profit
    FROM Superstore
    GROUP BY Category
)
SELECT s.Category, s.total_sales, p.total_profit,
ROUND(p.total_profit / s.total_sales * 100, 2) AS profit_margin_pct
FROM category_sales s
JOIN category_profit p ON s.Category = p.Category
ORDER BY profit_margin_pct DESC;

-- ============================================
-- MY FINDINGS FROM DAY 04:
-- 1. Subqueries nest one query inside another
-- 2. CTEs use WITH clause -- cleaner and reusable
-- 3. Furniture profit margin is only 2.49%
--    vs Technology at 17.4% and Office Supplies 17.04%
-- 4. For every $100 of Furniture sold the store
--    keeps only $2.49 -- shocking!
-- 5. CTEs are easier to read and debug than subqueries
-- ============================================
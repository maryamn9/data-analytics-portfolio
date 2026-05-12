-- ============================================
-- Day 07 | 12 May 2026 | Maryam Naveen
-- Dataset: UK Road Accidents 2005-2014
-- Source: Kaggle (DfT Stats19 data)
-- Records: 1,504,150
-- Topic: First complete SQL project
-- ============================================

-- Q1: Accidents per year — is UK getting safer?
SELECT Year,
COUNT(*) AS total_accidents
FROM UK_Accident
GROUP BY Year
ORDER BY Year ASC;

-- Q2: Which day of week is most dangerous?
-- 1=Sunday 2=Monday 3=Tuesday 4=Wednesday
-- 5=Thursday 6=Friday 7=Saturday
SELECT Day_of_Week,
COUNT(*) AS total_accidents
FROM UK_Accident
GROUP BY Day_of_Week
ORDER BY total_accidents DESC;

-- Q3: Weather conditions and accidents
SELECT Weather_Conditions,
COUNT(*) AS total_accidents
FROM UK_Accident
GROUP BY Weather_Conditions
ORDER BY total_accidents DESC
LIMIT 10;

-- Q4: Urban vs Rural breakdown
SELECT Urban_or_Rural_Area,
COUNT(*) AS total_accidents,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM UK_Accident), 2) AS percentage
FROM UK_Accident
GROUP BY Urban_or_Rural_Area;

-- Q5: Accident severity breakdown
SELECT Accident_Severity,
COUNT(*) AS total_accidents,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM UK_Accident), 2) AS percentage
FROM UK_Accident
GROUP BY Accident_Severity
ORDER BY Accident_Severity;

-- ============================================
-- KEY FINDINGS:
-- 1. UK roads getting SAFER every year
--    2005: 198,735 accidents → 2014: 146,322
-- 2. Friday is most dangerous day (247,137)
--    Sunday is safest (164,972)
-- 3. 80% of accidents happen in FINE weather!
--    People drive faster when conditions seem safe
-- 4. 64.62% urban vs 35.37% rural accidents
-- 5. 1.29% fatal (19,441 deaths)
--    85.11% slight injuries
-- ============================================
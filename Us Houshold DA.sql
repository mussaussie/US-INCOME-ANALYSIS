-- ==================================================
-- US Household Income Data Analysis
-- Database: us_income_project
-- ==================================================

-- ==================================================
-- PART 1: DATA CLEANING
-- ==================================================

-- Initial data exploration
SELECT * FROM us_income_project.ushouseholdincome;
SELECT * FROM us_income_project.ushouseholdincome_statistics;

-- --------------------------------------------------
-- 1. Remove Duplicate Records
-- --------------------------------------------------

-- Delete duplicate records from ushouseholdincome table
DELETE FROM ushouseholdincome
WHERE row_id IN (
    SELECT row_id 
    FROM (
        SELECT row_id, id,
               ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num
        FROM us_income_project.ushouseholdincome
    ) AS duplicates
    WHERE row_num > 1
);

-- Check for duplicates in statistics table
SELECT id, COUNT(id) AS duplicate_count
FROM ushouseholdincome_statistics
GROUP BY id
HAVING COUNT(id) > 1;

-- Note: Statistics table has no duplicates, but main table had 6 duplicates which were removed

-- --------------------------------------------------
-- 2. Fix Data Quality Issues
-- --------------------------------------------------

-- Fix misspelled state name: 'georia' -> 'Georgia'
UPDATE ushouseholdincome
SET State_name = 'Georgia'
WHERE State_name = 'georia';

-- Fix incorrect place name
UPDATE ushouseholdincome
SET place = 'Autaugaville'
WHERE City = 'Vinemont';

-- Review Type distribution
SELECT Type, COUNT(Type) AS count
FROM ushouseholdincome
GROUP BY Type
ORDER BY count DESC;

-- Standardize Type values: 'Boroughs' -> 'Borough'
UPDATE ushouseholdincome
SET Type = 'Borough'
WHERE Type = 'Boroughs';

-- Check for null or zero values in land and water area
SELECT ALAND, AWATER
FROM ushouseholdincome
WHERE ALAND IN ('', '0')
   OR AWATER IN ('', '0');

-- Data cleaning complete


-- ==================================================
-- PART 2: EXPLORATORY DATA ANALYSIS
-- ==================================================

-- --------------------------------------------------
-- 3. Geographic Analysis: Land and Water Area
-- --------------------------------------------------

-- States with largest total land area
SELECT 
    State_Name, 
    SUM(ALAND) AS Total_Land_Area, 
    SUM(AWATER) AS Total_Water_Area
FROM ushouseholdincome
GROUP BY State_Name
ORDER BY Total_Land_Area DESC
LIMIT 10;
-- Result: Texas has the largest land area

-- States with largest total water area
SELECT 
    State_Name, 
    SUM(ALAND) AS Total_Land_Area, 
    SUM(AWATER) AS Total_Water_Area
FROM ushouseholdincome
GROUP BY State_Name
ORDER BY Total_Water_Area DESC
LIMIT 10;
-- Result: Michigan has the largest water area

-- --------------------------------------------------
-- 4. Income Analysis by State
-- --------------------------------------------------

-- Average mean and median income by state
SELECT 
    ui.State_Name,
    ROUND(AVG(us.Mean), 2) AS Avg_Mean_Income,
    ROUND(AVG(us.Median), 2) AS Avg_Median_Income
FROM ushouseholdincome AS ui
INNER JOIN ushouseholdincome_statistics AS us
    ON ui.id = us.id
WHERE us.Mean <> 0
GROUP BY ui.State_Name
ORDER BY Avg_Mean_Income DESC;

-- --------------------------------------------------
-- 5. Income Analysis by Community Type
-- --------------------------------------------------

-- Average income by type (with minimum 100 occurrences)
SELECT 
    ui.Type,
    COUNT(ui.Type) AS Count,
    ROUND(AVG(us.Mean), 1) AS Avg_Mean_Income,
    ROUND(AVG(us.Median), 1) AS Avg_Median_Income
FROM ushouseholdincome AS ui
INNER JOIN ushouseholdincome_statistics AS us
    ON ui.id = us.id
WHERE us.Mean <> 0
GROUP BY ui.Type
HAVING COUNT(ui.Type) > 100
ORDER BY Avg_Median_Income DESC
LIMIT 20;

-- --------------------------------------------------
-- 6. Specific Analysis: Community Type Locations
-- --------------------------------------------------

-- Identify all Community type locations
SELECT * 
FROM ushouseholdincome
WHERE Type = 'Community';
-- Result: Puerto Rico has Community type locations with lower income

-- --------------------------------------------------
-- 7. Income Analysis by City
-- --------------------------------------------------

-- Cities with highest average income
SELECT 
    ui.State_Name,
    ui.City,
    ROUND(AVG(us.Mean), 1) AS Avg_Mean_Income,
    ROUND(AVG(us.Median), 1) AS Avg_Median_Income
FROM ushouseholdincome AS ui
INNER JOIN ushouseholdincome_statistics AS us
    ON ui.id = us.id
WHERE us.Mean <> 0
GROUP BY ui.State_Name, ui.City
ORDER BY Avg_Mean_Income DESC
LIMIT 20;
-- Result: Delta Junction, Alaska has the highest average mean income

-- Cities with lowest average income
SELECT 
    ui.State_Name,
    ui.City,
    ROUND(AVG(us.Mean), 1) AS Avg_Mean_Income,
    ROUND(AVG(us.Median), 1) AS Avg_Median_Income
FROM ushouseholdincome AS ui
INNER JOIN ushouseholdincome_statistics AS us
    ON ui.id = us.id
WHERE us.Mean <> 0
GROUP BY ui.State_Name, ui.City
ORDER BY Avg_Mean_Income ASC
LIMIT 20;

-- ==================================================
-- END OF ANALYSIS
-- ==================================================

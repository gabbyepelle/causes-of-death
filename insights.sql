-- ================================================
-- insights.sql
-- ================================================


-- INSIGHT 1: What is the #1 cause of death nationally, most recent year?
SELECT
  Year,
  `Cause Name`,
  `Age-adjusted Death Rate`
FROM `project-7229cb4d-9c14-43f3-814.1.deaths`
WHERE State = 'United States'
  AND `Cause Name` != 'All causes'
  AND Year = (SELECT MAX(Year) FROM `project-7229cb4d-9c14-43f3-814.1.deaths`)
ORDER BY `Age-adjusted Death Rate` DESC
LIMIT 1;


-- INSIGHT 2: Which 3 states have the highest heart disease death rate on average?
SELECT
  State,
  ROUND(AVG(`Age-adjusted Death Rate`), 2) AS avg_heart_disease_rate
FROM `project-7229cb4d-9c14-43f3-814.1.deaths`
WHERE `Cause Name` = 'Heart disease'
  AND State != 'United States'
GROUP BY State
ORDER BY avg_heart_disease_rate DESC
LIMIT 3;


-- INSIGHT 3: Which 3 states have the lowest heart disease death rate on average?
SELECT
  State,
  ROUND(AVG(`Age-adjusted Death Rate`), 2) AS avg_heart_disease_rate
FROM `project-7229cb4d-9c14-43f3-814.1.deaths`
WHERE `Cause Name` = 'Heart disease'
  AND State != 'United States'
GROUP BY State
ORDER BY avg_heart_disease_rate ASC
LIMIT 3;


-- INSIGHT 4: What year had the highest overall death rate nationally?
SELECT
  Year,
  ROUND(AVG(`Age-adjusted Death Rate`), 2) AS avg_rate
FROM `project-7229cb4d-9c14-43f3-814.1.deaths`
WHERE State = 'United States'
  AND `Cause Name` != 'All causes'
GROUP BY Year
ORDER BY avg_rate DESC
LIMIT 1;


-- INSIGHT 5: How many causes showed improvement vs got worse since 1999?
WITH first_last AS (
  SELECT DISTINCT
    `Cause Name`,
    FIRST_VALUE(`Age-adjusted Death Rate`) OVER (
      PARTITION BY `Cause Name` ORDER BY Year ASC
    ) AS rate_1999,
    FIRST_VALUE(`Age-adjusted Death Rate`) OVER (
      PARTITION BY `Cause Name` ORDER BY Year DESC
    ) AS rate_latest
  FROM `project-7229cb4d-9c14-43f3-814.1.deaths`
  WHERE State = 'United States'
    AND `Cause Name` != 'All causes'
)

SELECT
  COUNTIF(rate_latest < rate_1999) AS improved,
  COUNTIF(rate_latest > rate_1999) AS got_worse
FROM first_last;

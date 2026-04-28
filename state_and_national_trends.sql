-- ================================================
--state_and_national_trends.sql
-- Goal: Key findings summary for the README
-- ================================================




--leading cause of death by state and year
WITH ranked AS (
  SELECT
    Year,
    State,
    `Cause Name`,
    `Age-adjusted Death Rate`,
    RANK() OVER (
      PARTITION BY State, Year
      ORDER BY `Age-adjusted Death Rate` DESC
    ) AS rank
  FROM `project-7229cb4d-9c14-43f3-814.1.deaths`
  WHERE State != 'United States' 
    AND `Cause Name` != 'All causes' 
)

SELECT
  Year,
  State,
  `Cause Name`,
  `Age-adjusted Death Rate`
FROM ranked
WHERE rank = 1
ORDER BY State, Year;


--year over year change in cause of death
WITH yearly AS (
  SELECT
    Year,
    `Cause Name`,
    ROUND(AVG(`Age-adjusted Death Rate`), 2) AS avg_rate
  FROM `project-7229cb4d-9c14-43f3-814.1.deaths`
  WHERE State = 'United States' -- use national aggregate
    AND `Cause Name` != 'All causes'
  GROUP BY Year, `Cause Name`
)

SELECT
  Year,
  `Cause Name`,
  avg_rate,
  LAG(avg_rate) OVER (
    PARTITION BY `Cause Name`
    ORDER BY Year
  ) AS prev_year_rate,
  ROUND(avg_rate - LAG(avg_rate) OVER (
    PARTITION BY `Cause Name`
    ORDER BY Year
  ), 2) AS yoy_change
FROM yearly
ORDER BY `Cause Name`, Year;

--which cause has improved the most since 1999?

WITH first_last AS (
  SELECT
    `Cause Name`,
    FIRST_VALUE(`Age-adjusted Death Rate`) OVER (
      PARTITION BY `Cause Name`
      ORDER BY Year ASC
    ) AS rate_1999,
    FIRST_VALUE(`Age-adjusted Death Rate`) OVER (
      PARTITION BY `Cause Name`
      ORDER BY Year DESC
    ) AS rate_latest
  FROM `project-7229cb4d-9c14-43f3-814.1.deaths`
  WHERE State = 'United States'
    AND `Cause Name` != 'All causes'
),

summary AS (
  SELECT DISTINCT
    `Cause Name`,
    rate_1999,
    rate_latest,
    ROUND(rate_latest - rate_1999, 2) AS total_change,
    ROUND(((rate_latest - rate_1999) / rate_1999) * 100, 1) AS pct_change
  FROM first_last
)

SELECT *
FROM summary
ORDER BY pct_change ASC; 

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
  `Cause Name`,
  rate_1999,
  rate_latest,
  ROUND(rate_latest - rate_1999, 2) AS total_change
FROM first_last
WHERE rate_latest > rate_1999
ORDER BY total_change DESC;


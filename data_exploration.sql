-- ================================================
-- data_explorations.sql
-- ================================================
-- How many rows total?
SELECT COUNT(*) AS total_rows
FROM `project-7229cb4d-9c14-43f3-814.1.deaths`;

-- What years are covered?
SELECT 
  MIN(Year) AS earliest_year,
  MAX(Year) AS latest_year
FROM `project-7229cb4d-9c14-43f3-814.1.deaths`;

-- What causes of death are in the dataset?
SELECT DISTINCT `Cause Name`
FROM `project-7229cb4d-9c14-43f3-814.1.deaths`
ORDER BY `Cause Name`;

-- Null check
SELECT
  COUNTIF(Year IS NULL)                     AS null_years,
  COUNTIF(State IS NULL)                    AS null_states,
  COUNTIF(`Cause Name` IS NULL)               AS null_causes,
  COUNTIF(Deaths IS NULL)                   AS null_deaths,
  COUNTIF(`Age-adjusted Death Rate` IS NULL)  AS null_rates
FROM `project-7229cb4d-9c14-43f3-814.1.deaths`;


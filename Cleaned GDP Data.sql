CREATE OR REPLACE TABLE `gdp_data.cleaned_data` AS
SELECT *
FROM `gdp_data.Data`
WHERE gdppc IS NOT NULL AND gdppc > 0;


CREATE OR REPLACE TABLE `gdp_data.avg_gdp_data` AS
SELECT
  country,
  year,
  AVG(gdppc) AS avg_gdppc
FROM `gdp_data.cleaned_data`
GROUP BY country, year;


CREATE OR REPLACE TABLE `gdp_data.gdp_growth_data` AS
SELECT
  a.country,
  a.year,
  a.avg_gdppc,
  SAFE_DIVIDE(a.avg_gdppc - b.avg_gdppc, b.avg_gdppc) AS gdp_growth
FROM `gdp_data.avg_gdp_data` a
JOIN `gdp_data.avg_gdp_data` b
  ON a.country = b.country AND a.year = b.year + 1;


CREATE OR REPLACE TABLE `gdp_data.gdp_growth_data_with_lag` AS
SELECT
  a.country,
  a.year,
  a.avg_gdppc,
  a.gdp_growth,
  b.gdp_growth AS lagged_gdp_growth
FROM `gdp_data.gdp_growth_data` a
LEFT JOIN `gdp_data.gdp_growth_data` b
  ON a.country = b.country AND a.year = b.year + 1
WHERE a.gdp_growth IS NOT NULL;
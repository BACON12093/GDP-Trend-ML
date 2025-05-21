CREATE OR REPLACE MODEL `gdp_data.gdp_growth_regression_model`
OPTIONS(
  model_type = 'linear_reg',
  input_label_cols = ['gdp_growth'],
  max_iterations = 20,
  data_split_method = 'random',
  data_split_eval_fraction = 0.2,
  early_stop = TRUE
) AS
SELECT
  country,
  year,
  avg_gdppc,
  lagged_gdp_growth,
  gdp_growth
FROM `gdp_data.gdp_growth_data_with_lag`
WHERE gdp_growth BETWEEN -0.5 AND 0.5;

CREATE OR REPLACE TABLE `gdp_data.gdp_growth_predictions` AS
SELECT
  country,
  year AS predicted_year,
  predicted_gdp_growth
FROM ML.PREDICT(
  MODEL `gdp_data.gdp_growth_regression_model`,
  (
    WITH latest_data AS (
      SELECT
        country,
        MAX(year) AS last_year,
        ANY_VALUE(avg_gdppc) AS last_avg_gdppc,
        ANY_VALUE(gdp_growth) AS last_gdp_growth
      FROM `gdp_data.gdp_growth_data_with_lag`
      GROUP BY country
    )
    SELECT
      country,
      last_year + 1 AS year,
      last_avg_gdppc AS avg_gdppc,
      last_gdp_growth AS lagged_gdp_growth
    FROM latest_data
  )
);


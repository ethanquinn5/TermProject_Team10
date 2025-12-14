CREATE OR REPLACE MODEL `mgmt-467-94721.hotel_bookings.cancel_model_with_weather`
OPTIONS(
  model_type = 'logistic_reg',
  input_label_cols = ['label']
) AS
SELECT
  hotel,
  booking_city,
  lead_time,
  arrival_date_year,
  arrival_date_week_number,
  stays_in_weekend_nights,
  stays_in_week_nights,
  total_guests,
  deposit_type,
  customer_type,
  total_of_special_requests,
  temp_c,
  windspeed,
  weather_code,
  label
FROM `mgmt-467-94721.hotel_bookings.training_data`;

SELECT *
FROM ML.EVALUATE(MODEL `mgmt-467-94721.hotel_bookings.cancel_model_with_weather`);


CREATE OR REPLACE MODEL `mgmt-467-94721.hotel_bookings.cancel_model`
OPTIONS(
  model_type = 'logistic_reg',
  input_label_cols = ['label']
) AS
SELECT
  hotel,
  booking_city,
  lead_time,
  arrival_date_year,
  arrival_date_week_number,
  stays_in_weekend_nights,
  stays_in_week_nights,
  total_guests,
  deposit_type,
  customer_type,
  total_of_special_requests,
  label
FROM `mgmt-467-94721.hotel_bookings.training_data`;

SELECT *
FROM ML.EVALUATE(
  MODEL `mgmt-467-94721.hotel_bookings.cancel_model`
);


CREATE OR REPLACE MODEL `mgmt-467-94721.hotel_bookings.cancel_model_historical_weather`
OPTIONS(
  model_type = 'logistic_reg',
  input_label_cols = ['label']
) AS
SELECT
  hotel,
  lead_time,
  arrival_date_year,
  arrival_date_week_number,
  stays_in_weekend_nights,
  stays_in_week_nights,
  (adults + COALESCE(children, 0) + babies) AS total_guests,
  deposit_type,
  customer_type,
  total_of_special_requests,

  -- historical weather features
  temperature_2m_mean,
  temperature_2m_max,
  temperature_2m_min,
  precipitation_sum,
  windspeed_10m_max,
  weathercode,

  is_canceled AS label
FROM `mgmt-467-94721.hotel_bookings.weather_history`
WHERE (adults + COALESCE(children, 0) + babies) > 0;

SELECT *
FROM ML.EVALUATE(
  MODEL `mgmt-467-94721.hotel_bookings.cancel_model_historical_weather`
);

SELECT *
FROM ML.EXPLAIN_PREDICT(
  MODEL `mgmt-467-94721.hotel_bookings.cancel_model_historical_weather`,
  (
    SELECT *
    FROM `mgmt-467-94721.hotel_bookings.weather_history`
    LIMIT 50
  ),
  STRUCT(5 AS top_k_features)   -- show top 5 features per row
);

WITH preds AS (
  SELECT *
  FROM ML.EXPLAIN_PREDICT(
    MODEL `mgmt-467-94721.hotel_bookings.cancel_model_historical_weather`,
    (SELECT * FROM `mgmt-467-94721.hotel_bookings.weather_history` LIMIT 50),
    STRUCT(5 AS top_k_features)
  )
)
SELECT
  predicted_label,
  probability,
  feature_attr.feature,
  feature_attr.attribution
FROM preds,
UNNEST(top_feature_attributions) AS feature_attr;

WITH explained AS (
  SELECT
    attr.feature AS feature,
    ABS(attr.attribution) AS abs_attr
  FROM ML.EXPLAIN_PREDICT(
    MODEL `mgmt-467-94721.hotel_bookings.cancel_model_historical_weather`,
    (
      -- SAMPLE 1000 rows from training data for global importance
      SELECT *
      FROM `mgmt-467-94721.hotel_bookings.weather_history`
      LIMIT 1000
    ),
    STRUCT(5 AS top_k_features)
  ),
  UNNEST(top_feature_attributions) AS attr
)
SELECT
  feature,
  AVG(abs_attr) AS avg_influence
FROM explained
GROUP BY feature
ORDER BY avg_influence DESC;


WITH explain AS (
  SELECT
    hotel,
    f.feature AS feature,
    f.attribution AS attribution
  FROM ML.EXPLAIN_PREDICT(
    MODEL `mgmt-467-94721.hotel_bookings.cancel_model_historical_weather`,
    (
      -- sample rows across both hotels
      SELECT *
      FROM `mgmt-467-94721.hotel_bookings.weather_history`
      LIMIT 2000
    ),
    STRUCT(1000 AS top_k_features)   -- include lots of features per row
  ),
  UNNEST(top_feature_attributions) AS f
)
SELECT
  hotel,
  feature,
  AVG(ABS(attribution)) AS avg_influence
FROM explain
GROUP BY hotel, feature
ORDER BY hotel, avg_influence DESC;


WITH explain AS (
  SELECT
    hotel,
    f.feature AS feature,
    f.attribution AS attribution
  FROM ML.EXPLAIN_PREDICT(
    MODEL `mgmt-467-94721.hotel_bookings.cancel_model_historical_weather`,
    (
      -- sample 2000 rows across both hotels
      SELECT *
      FROM `mgmt-467-94721.hotel_bookings.weather_history`
      LIMIT 2000
    ),
    STRUCT(1000 AS top_k_features)
  ),
  UNNEST(top_feature_attributions) AS f
)
SELECT
  hotel,
  feature,
  AVG(ABS(attribution)) AS avg_influence
FROM explain
WHERE feature IN ({weather_feature_list})
GROUP BY hotel, feature
ORDER BY hotel, avg_influence DESC;
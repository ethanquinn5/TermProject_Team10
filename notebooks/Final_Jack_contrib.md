# Individual Contribution Summary – Jack Strabala

## Overview
I was responsible for designing and implementing the weather-related components of the analytics pipeline, conducting exploratory analysis on cancellation behavior, and building and interpreting machine learning models that integrate historical weather data with hotel booking data.

---

### Data Engineering & Ingestion
- Loaded and curated the Kaggle hotel booking dataset into BigQuery, including schema validation and data quality filtering.
- Designed and implemented the historical weather data ingestion workflow using Open-Meteo data.
- Deployed a Cloud Run Function to ingest live weather data and publish it to Pub/Sub.
- Verified the streaming pipeline by confirming real-time inserts into the BigQuery streaming weather table.

**Relevant files / components:**
- `pipeline/function/`
- `bq/sql/`
- BigQuery tables: `hotel_bookings_curated`, `weather_history`, `streaming_weather`

---

### Exploratory Data Analysis
- Conducted exploratory analysis of hotel booking cancellations by:
  - Deposit type
  - Lead time
  - Month and season
  - Weather variables (temperature and wind speed)
- Identified non-linear and seasonal patterns through binning and aggregation.
- Built interactive Plotly visualizations to support analytical storytelling.

**Relevant notebook:**
- `notebooks/Final_Jack_analysis.ipynb`

---

### Machine Learning & Explainability
- Built a baseline BigQuery ML logistic regression model using booking-related features only.
- Built a weather-enhanced BigQuery ML model incorporating historical weather features.
- Compared model performance using `ML.EVALUATE`.
- Used `ML.EXPLAIN_PREDICT` to interpret feature importance and assess the marginal impact of weather variables.

---

### Dashboard & Communication
- Defined KPIs used in the Looker Studio dashboard, including cancellation rate by season and weather condition.
- Ensured dashboard metrics aligned with BigQuery query outputs.
- Assisted in translating analytical results into executive-friendly insights.

---

## Lessons Learned
- Weather variables provide incremental predictive power when combined with core booking features but are highly context-dependent.
- Careful validation of AI-generated SQL is essential, especially when binning continuous variables.
- Streaming data is more valuable for operational monitoring and dashboards than for historical model training.
- Model explainability tools are critical for distinguishing signal from noise in feature-rich datasets.

---

## Pull Requests / References
- BigQuery SQL queries and model definitions committed to the team repository.
- Notebook commits containing EDA, modeling, and visualization work.
- Dashboard metrics documented in `dashboards/kpis.md`.

---

## Time & Collaboration
- Collaborated with teammates on architecture design and demo preparation.
- Reviewed teammate code and contributed feedback on model interpretation and dashboard clarity.

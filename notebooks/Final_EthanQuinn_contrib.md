# Project Contribution Summary
**Name:** Ethan Quinn  
**Course Project:** Hotel Booking Cancellation Analysis  
**Deliverable:** Final_Ethan_Quinn_contrib.md  

---

## Overview

My primary contribution to this project focused on building the real-time and analytical data infrastructure used to analyze hotel booking cancellations in Portugal. This included implementing streaming weather data ingestion, integrating weather features into the modeling pipeline, developing predictive models in BigQuery ML, and contributing multiple repository artifacts and dashboard components that supported deployment, governance, and interpretation.

---

## Exact Tasks Completed

### Streaming Data and Weather Integration
- Implemented ingestion of live weather data into BigQuery using a streaming table.
- Queried streaming weather data (`hotel_stream.weather_live`) for use in both model validation and real-time prediction scenarios.
- Validated that streaming weather inputs were stable and aligned with historical weather distributions used during model training.
- Integrated live weather values into BigQuery ML prediction queries via cross joins for real-time scoring.

### Data Engineering and Preparation
- Extracted raw hotel booking data from BigQuery and loaded it into Google Colab for transformation.
- Filtered bookings to Portugal-only records to maintain geographic consistency.
- Engineered derived features such as total guest count and constructed proper arrival date fields.
- Applied data quality filters to remove invalid records (e.g., zero guests, negative ADR).
- Published a curated hotel bookings table back to BigQuery for reuse across modeling and dashboards.

### Modeling and Analysis
- Designed and trained a logistic regression cancellation model using BigQuery ML.
- Selected booking behavior, customer attributes, and weather variables as model inputs.
- Evaluated model performance using precision, recall, accuracy, F1 score, log loss, and ROC AUC.
- Interpreted model weights and explainability outputs to identify the strongest drivers of cancellation risk.

### Visualization and Dashboard Contributions
- Created two time-series visualizations in Looker Studio:
  - A dual-axis weather time series showing temperature and wind speed.
  - A precipitation time series highlighting rainfall patterns over time.
- Used these charts to validate streaming weather inputs and demonstrate that weather had limited predictive influence relative to booking behavior variables.
- Provided analytical context that informed the cancellation risk and feature importance sections of the final dashboard.

### Pipeline, Infrastructure, and Repository Contributions
- Added the Cloud Function and associated configuration files to the repository (`pipeline/function`).
- Documented Dataflow template parameters and usage (`pipeline/dataflow`).
- Defined infrastructure setup steps including required APIs, service account roles, and deployment commands (`pipeline/infra`).
- Added KPI definitions and dashboard linkage documentation (`dashboards/kpis.md`).
- Contributed architectural and governance documentation, including:
  - `blueprint.pdf`
  - `governance.pdf`
- Helped organize the repository to clearly separate notebooks, SQL queries, pipeline components, dashboards, and documentation.

### AI-Assisted Workflow
- Used AI assistance to generate and refine SQL queries, feature engineering logic, streaming queries, and visualization code.
- Validated all AI-generated outputs through row counts, schema inspection, model evaluation metrics, and comparison against expected data behavior.

---

## Lessons Learned

- Streaming data is valuable for validation, monitoring, and real-time scoring even when it is not a primary driver in a predictive model.
- Booking behavior and customer intent variables are significantly more predictive of cancellations than external environmental factors.
- Separating infrastructure, pipeline logic, analytics, and documentation improves clarity and maintainability in team projects.
- AI-assisted development is most effective when paired with systematic validation and domain reasoning.

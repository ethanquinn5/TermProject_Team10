# TermProject_Team10: Hotel Booking Cancellations and Weather Impact

## Project Overview
This project analyzes hotel booking cancellation behavior by combining batch hotel booking data with historical and real-time weather data. The objective is to assess whether weather conditions provide insight into cancellations along with traditional booking features, while demonstrating a complete batch-plus-streaming analytics pipeline.

The project integrates:
- Batch ingestion of hotel booking data from Kaggle
- Streaming ingestion of live weather data from the Open-Meteo API
- Historical weather data for model training
- BigQuery ML models for cancellation prediction
- An executive dashboard built in Looker Studio

## Business Question
**Do weather conditions meaningfully influence hotel booking cancellations, and can weather data improve cancellation prediction when combined with booking characteristics such as lead time and deposit type?**

## Data Sources
- **Batch data:** Kaggle Hotel Booking Demand dataset  
- **Streaming data:** Open-Meteo public weather API  
- **Historical weather:** Open-Meteo historical weather data joined to bookings by date and location  

## Analytics & Modeling
- Baseline BigQuery ML cancellation model using booking features
- Weather-enhanced model incorporating historical weather data
- Model evaluation using `ML.EVALUATE`
- Explainability using `ML.EXPLAIN_PREDICT`

## Dashboard
A Looker Studio dashboard presents:
- Cancellation rate KPIs
- Seasonal trends
- Weather-based cancellation patterns
- Interactive filters for hotel type

Dashboard link and KPI definitions are provided in `dashboards/kpis.md`.

## Reproducibility & Operations
- Pipeline operations are documented in `docs/ops_runbook.md`
- Infrastructure setup notes are included under `pipeline/infra/`

## Team Contributions
Each team member completed an individual analysis notebook and documented their work


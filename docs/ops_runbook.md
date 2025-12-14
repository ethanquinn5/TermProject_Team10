# Operations Runbook

## Project Overview
This project ingests historical and real-time weather data from the Open-Meteo API and combines it with hotel booking data to analyze and predict booking cancellations. The pipeline consists of a Cloud Run Function publishing weather data to Pub/Sub, a Dataflow streaming job writing to BigQuery, and downstream analytics using BigQuery ML and Looker Studio.

---

## Architecture Summary
- **Batch source:** Kaggle hotel booking dataset (loaded into BigQuery)
- **Streaming source:** Open-Meteo API
- **Ingestion:** Cloud Run Function (2nd gen)
- **Messaging:** Pub/Sub topic and subscription
- **Streaming pipeline:** Dataflow template (Pub/Sub → BigQuery)
- **Storage:** BigQuery tables (`weather_history`, `streaming_weather`)
- **Analytics:** BigQuery ML models
- **Visualization:** Looker Studio dashboard

---

## How to Start the Pipeline
1. Ensure required APIs are enabled:
   - Cloud Run
   - Pub/Sub
   - Dataflow
   - BigQuery

2. Verify the Cloud Run Function is deployed and active.
   - Confirm the function endpoint returns a success response.

3. Confirm the Pub/Sub topic and subscription exist.
   - Topic: `hotel-weather-topic`
   - Subscription: `hotel-weather-sub`

4. Start the Dataflow streaming job using the Pub/Sub → BigQuery template.
   - Confirm the target BigQuery table is set to streaming insert mode.

---

## How to Verify Data Is Flowing
1. **Cloud Run logs**
   - Check logs for successful API calls to Open-Meteo.
   - Verify weather payloads are being published to Pub/Sub.

2. **Pub/Sub metrics**
   - Messages published should increase over time.
   - Subscription backlog should remain near zero.

3. **BigQuery validation**
   - Run:
     ```sql
     SELECT *
     FROM `project.dataset.streaming_weather`
     ORDER BY ingestion_time DESC
     LIMIT 10;
     ```
   - Confirm new rows appear within a few minutes.

---

## Common Failure Scenarios & Fixes

### Issue: No new rows in BigQuery
- Check Cloud Run logs for API errors or timeouts.
- Verify Pub/Sub subscription is active.
- Confirm Dataflow job is running and not in a failed state.

### Issue: Open-Meteo API returns errors
- Confirm request parameters (latitude, longitude).
- Check rate limits and retry logic.
- Temporarily reduce call frequency if needed.

### Issue: Dataflow job fails
- Review Dataflow logs for schema mismatches.
- Ensure BigQuery table schema matches incoming JSON.

---

## Cost Controls
- Cloud Run function is lightweight and invoked periodically.
- Dataflow job should be stopped when not actively demonstrating streaming.
- BigQuery streaming inserts are limited to a small number of rows per hour.

---

## Security & Access
- No API keys are required for Open-Meteo.
- Cloud Run and Dataflow use service accounts with minimum required permissions.
- BigQuery access is restricted to project members.

---

## How to Shut Down the Pipeline
1. Stop the Dataflow streaming job.
2. Disable or undeploy the Cloud Run Function.
3. (Optional) Delete Pub/Sub subscription if no longer needed.

---

## Reproducibility Notes
- All infrastructure can be recreated using the documented steps in the README.
- Tables can be safely dropped and reloaded without impacting source data.

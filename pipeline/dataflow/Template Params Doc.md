# Dataflow Pipeline

## Overview
This project uses a **Google-provided streaming Dataflow template** to ingest
real-time weather data from **Pub/Sub** and write it into **BigQuery** for
downstream analytics and modeling.

The pipeline is implemented using the **Pub/Sub to BigQuery (Streaming)**
template and does not require custom Apache Beam code.

---

## Template Used
**Pub/Sub to BigQuery (Streaming)**

Official documentation:
https://cloud.google.com/dataflow/docs/guides/templates/provided/pubsub-to-bigquery

---

## Template Parameters

The following template parameters were configured when launching the Dataflow job:

| Parameter | Value / Description |
|---------|--------------------|
| `inputTopic` | Pub/Sub topic receiving live weather messages |
| `outputTableSpec` | BigQuery destination table for streaming weather data |
| `writeDisposition` | WRITE_APPEND |
| `useStorageWriteApi` | true |
| `useStorageWriteApiAtLeastOnce` | true |

---

## Data Characteristics
- **Pipeline type:** Streaming
- **Source:** Pub/Sub
- **Sink:** BigQuery
- **Update frequency:** Approximately every 10 minutes
- **Schema:** Weather metrics including temperature, precipitation, and wind speed

---

## Job Execution
The Dataflow job is launched from the Google Cloud Console using the
pre-built template interface. Job configuration and execution are fully
managed by Google Cloud.

A screenshot of the Dataflow job execution graph is included in the final submission
as required.

---

## Failure Handling
- Pub/Sub provides message durability in case of temporary failures.
- Dataflow automatically retries failed workers.
- BigQuery WRITE_APPEND ensures no existing data is overwritten.

---

## Teardown
The pipeline can be stopped manually by cancelling the Dataflow job in the
Google Cloud Console. No additional infrastructure teardown is required.

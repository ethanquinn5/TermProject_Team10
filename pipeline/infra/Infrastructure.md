# Infrastructure (Infra)

Overview
This project uses Google Cloud Platform (GCP) managed services. Infrastructure
setup consists of enabling required APIs, configuring IAM permissions, and
creating supporting resources such as Pub/Sub topics and BigQuery datasets.
No Infrastructure-as-Code (IaC) tools (e.g., Terraform) were used.

Enabled GCP Services
The following APIs must be enabled:
- BigQuery API
- Pub/Sub API
- Dataflow API
- Cloud Functions API
- Cloud Run API
- Cloud Scheduler API
- Artifact Registry API

Service Accounts and IAM
The Dataflow streaming job runs using the default Compute Engine service account:
<PROJECT_NUMBER>-compute@developer.gserviceaccount.com

Assigned roles:
- roles/dataflow.worker
- roles/bigquery.dataEditor
- roles/bigquery.jobUser
- roles/pubsub.subscriber

Pub/Sub Infrastructure
A Pub/Sub topic is used to ingest real-time weather data:
projects/<PROJECT_ID>/topics/weather-stream

Messages are JSON-formatted weather observations published on a scheduled basis.

BigQuery Infrastructure
Datasets:
- hotel_stream: streaming weather data
- hotel_batch: batch hotel bookings and historical weather joins

Tables:
- hotel_stream.weather_live
- hotel_batch.hotel_bookings_curated_with_weather

Cloud Scheduler
Cloud Scheduler triggers the weather ingestion pipeline approximately every
10 minutes.

Deployment Steps
1. Enable required services:
gcloud services enable bigquery.googleapis.com pubsub.googleapis.com dataflow.googleapis.com cloudfunctions.googleapis.com run.googleapis.com cloudscheduler.googleapis.com

2. Create the Pub/Sub topic:
gcloud pubsub topics create weather-stream

3. Deploy the weather ingestion service using Cloud Functions or Cloud Run.

4. Launch the Dataflow streaming job using the Pub/Sub to BigQuery template.

Teardown
To remove infrastructure resources:
- Stop the Dataflow streaming job
- Delete the Pub/Sub topic
- Delete BigQuery datasets if no longer needed

Notes
All infrastructure was configured using the Google Cloud Console and gcloud CLI
commands. No persistent compute resources are required.

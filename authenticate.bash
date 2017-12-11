#!/usr/bin/env bash

gcloud auth activate-service-account "$SERVICE_ACCOUNT" --key-file=/gcp/gcp-credentials.json
gcloud container clusters get-credentials "$CLUSTER" --zone "$ZONE" --project "$PROJECT"

/usr/bin/env bash

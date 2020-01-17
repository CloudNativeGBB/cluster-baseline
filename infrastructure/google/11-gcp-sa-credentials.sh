#! /bin/bash

# Create/Get SA credential file in JSON file
gcloud iam service-accounts keys create $GOOGLE_APPLICATION_CREDENTIALS \
  --iam-account "$GCP_SERVICE_ACCOUNT_NAME@$GCP_PROJECT_NAME.iam.gserviceaccount.com"
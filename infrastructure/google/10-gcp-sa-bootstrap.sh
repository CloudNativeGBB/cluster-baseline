export GCP_PROJECT_NAME="azure-arc-demo-######"
export GCP_SERVICE_ACCOUNT_NAME="azure-arc-tf-demo-sa"
export GOOGLE_APPLICATION_CREDENTIALS="./gcloud-key.json"

# Create SA account for gcloud
gcloud iam service-accounts create $GCP_SERVICE_ACCOUNT_NAME \
    --description "Azure ARC Terraform demo SA" \
    --display-name "Azure-ARC-TF-SA"

# Set role for SA account
gcloud projects add-iam-policy-binding $GCP_PROJECT_NAME \
  --member "serviceAccount:$GCP_SERVICE_ACCOUNT_NAME@$GCP_PROJECT_NAME.iam.gserviceaccount.com" \
  --role roles/owner

# Create/Get SA credential file in JSON file
gcloud iam service-accounts keys create $GOOGLE_APPLICATION_CREDENTIALS \
  --iam-account "$GCP_SERVICE_ACCOUNT_NAME@$GCP_PROJECT_NAME.iam.gserviceaccount.com"
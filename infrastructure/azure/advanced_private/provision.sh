#! /bin/bash

export WORKING_DIR="$(pwd)"
export NETWORKING_DIR=$WORKING_DIR"/networking"
export AKS_DIR=$WORKING_DIR"/aks"

# Setup Networking
echo "Deploy Networking"

cd $NETWORKING_DIR
terraform init
terraform plan -out tfplan
terraform apply -auto-approve tfplan 

echo "Networking deployed"


# Setup ACR
echo "Deploy AKS into networking"

cd $AKS_DIR
terraform init
terraform plan -out tfplan
terraform apply -auto-approve tfplan 

echo "AKS deployed"
#! /bin/bash

export WORKING_DIR="$(pwd)"
export NETWORKING_DIR=$WORKING_DIR"/networking"
export AKS_DIR=$WORKING_DIR"/aks"
export JUMPBOX_DIR=$WORKING_DIR"/jumpbox"

# Setup Networking
echo "Deploy Networking"

cd $NETWORKING_DIR
terraform init
terraform plan -out tfplan
terraform apply -auto-approve tfplan 

echo "Networking deployed"


# Setup AKS
echo "Deploy AKS into networking"

cd $AKS_DIR
terraform init
terraform plan -out tfplan
terraform apply -auto-approve tfplan 

echo "AKS deployed"

# Setup JUMPBOX
echo "Deploy JUMPBOX into networking"

cd $JUMPBOX_DIR
terraform init
terraform plan -out tfplan
terraform apply -auto-approve tfplan 

echo "JUMPBOX deployed"
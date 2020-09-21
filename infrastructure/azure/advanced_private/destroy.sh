#! /bin/bash

export WORKING_DIR="$(pwd)"
export NETWORKING_DIR=$WORKING_DIR"/networking"
export AKS_DIR=$WORKING_DIR"/aks"

# Destroy AKS
echo "Destroy AKS"

cd $AKS_DIR
terraform -auto-approve destroy 

echo "AKS destroyed"

# Destroy Networking
echo "Destroy Networking"

cd $NETWORKING_DIR
terraform -auto-approve destroy 

echo "Networking destroyed"

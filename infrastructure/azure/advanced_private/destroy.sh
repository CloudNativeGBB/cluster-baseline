#! /bin/bash

export WORKING_DIR="$(pwd)"
export NETWORKING_DIR=$WORKING_DIR"/networking"
export AKS_DIR=$WORKING_DIR"/aks"
export JUMPBOX_DIR=$WORKING_DIR"/jumpbox"


# Destroy JUMPBOX
echo "Destroy JUMPBOX"

cd $JUMPBOX_DIR
terraform -auto-approve destroy 

echo "JUMPBOX destroyed"

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

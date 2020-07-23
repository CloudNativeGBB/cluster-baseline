#!/bin/bash

# Load Parameters
LA_WORKSPACE=$1
LA_WORKSPACE_RG=$2
ARC_CLUSTER_NAME=$3
ARC_CLUSTER_RG=$4
TEST=$5

echo $TEST

# Get Log Analytics Workspace Details
LA_WORKSPACE_ID=$(az monitor log-analytics workspace show --resource-group $LA_WORKSPACE_RG --workspace-name $LA_WORKSPACE -o tsv --query id)
LA_WORKSPACE_KEY=$(az monitor log-analytics workspace get-shared-keys --resource-group $LA_WORKSPACE_RG --workspace-name $LA_WORKSPACE -o tsv --query primarySharedKey)

# Get Arc Cluster ID
ARC_CLUSTER_ID=$(az connectedk8s show -g $ARC_CLUSTER_RG -n $ARC_CLUSTER_NAME -o tsv --query id)

# Build azure monitor values file
cat <<EOF >> azure-monitor-values.yaml
omsagent:
  secret:
    wsid: '$LA_WORKSPACE_ID'
    key: '$LA_WORKSPACE_KEY'
  env:
    clusterName: '$ARC_CLUSTER_ID'
EOF

kubectl create secret generic azure-monitor-conn --from-file=azure-monitor-values.yaml -n kube-system


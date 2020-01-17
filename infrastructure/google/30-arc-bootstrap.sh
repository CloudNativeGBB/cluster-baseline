export CLUSTER_NAME="gke-arc-demo-cluster"
export CLUSTER_RG="AzureArcTest"
export GIT_REPO="git@github.com:CloudNativeGBB/cluster-baseline.git"

az connectedk8s connect --name $CLUSTER_NAME --resource-group $CLUSTER_RG

az k8sconfiguration create \
    --name cluster-config \
    --cluster-name $CLUSTER_NAME \
    --resource-group $CLUSTER_RG \
    --operator-instance-name cluster-config \
    --operator-namespace cluster-config \
    --repository-url $GIT_REPO \
    --operator-params="--git-readonly --git-path=manifests" \
    -o json

az k8sconfiguration show --resource-group $CLUSTER_RG \
    --name cluster-config \
    --cluster-name $CLUSTER_NAME \
    -o json
#!/bin/bash

RG=$1
CLUSTER_NAME=$2

az k8sconfiguration create -g $RG \
-c $CLUSTER_NAME \
-n baseline-config \
--enable-helm-operator \
--helm-operator-version='0.6.0' \
--helm-operator-params='--set helm.versions=v3' \
--repository-url https://github.com/CloudNativeGBB/cluster-baseline.git \
--operator-params="--git-branch monitoring --git-readonly --git-path=manifests --sync-garbage-collection" \
--scope cluster \
--operator-instance-name baseline-config \
--operator-namespace baseline-config \
--cluster-type connectedClusters
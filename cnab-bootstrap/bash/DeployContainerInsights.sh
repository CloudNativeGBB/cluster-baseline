#!/bin/bash

LA_ID=$1
LA_REGION=$2
LA_RG=$3

az deployment group create --resource-group $LA_RG --name deployment --template-file  ./arm-templates/ContainerInsights.json --parameters workspaceResourceId=$LA_ID workspaceRegion=$LA_REGION
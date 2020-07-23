#!/bin/bash

helm delete prometheus-operator -n monitoring
helm delete sealed-secrets -n kube-system
helm delete azure-monitor -n kube-system

kubectl delete ns baseline-config
kubectl delete ns dev
kubectl delete ns dummy-ns
kubectl delete ns falco
kubectl delete ns monitoring
kubectl delete ns production
kubectl delete ns staging
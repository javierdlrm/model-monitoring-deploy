#!/bin/bash

#
# Model monitoring operator
#

echo "Kubectl: deploying model-monitoring-operator"
kubectl apply -f model-monitoring.yaml

echo "Kubectl: verify everything is running"
kubectl get all -n model-monitoring-system
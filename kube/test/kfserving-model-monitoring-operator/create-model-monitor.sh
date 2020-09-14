#!/bin/bash

#
# Model monitor
#

echo "Kubectl: creating model monitor"
kubectl apply -f model-monitor.yaml

echo "Kubectl: verify logger is running"
kubectl get pods --watch
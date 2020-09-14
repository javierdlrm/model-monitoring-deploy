#!/bin/bash

#
# KFServing logger to Kafka
#

echo "Kubectl: Deleting topic"
kubectl delete -f kafka-topic.yaml -n kafka-operator

echo "Kubectl: Deleting model"
kubectl delete -f inference-service.yaml

echo "Kubectl: Deleting model monitor"
kubectl delete -f model-monitor.yaml

echo "Kubectl: Deleting model-monitoring-operator"
kubectl delete -f model-monitoring.yaml

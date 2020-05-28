#!/bin/sh

#
# KFServing logger to Kafka
#

echo "Kubectl: Deleting kafka bridge"
kubectl delete -f kafka-bridge.yaml -n kafka-operator

echo "Kubectl: Deleting test-topic"
kubectl delete -f kafka-topic.yaml -n kafka-operator

echo "Kubectl: Deleting model"
kubectl delete -f inference-service.yaml
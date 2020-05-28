#!/bin/sh

#
# Kafka test
#

echo "Kubectl: Deleting test-topic"
kubectl delete -f kafka-topic.yaml -n kafka-operator

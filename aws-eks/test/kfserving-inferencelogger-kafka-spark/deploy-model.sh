#!/bin/bash

#
# KFServing logger to Kafka
#

echo "Kubectl: serving model"
kubectl apply -f inference-service.yaml

echo "Kubectl: waiting until model is served"
kubectl wait inferenceservice/flowers-sample --for=condition=Ready --timeout=240s

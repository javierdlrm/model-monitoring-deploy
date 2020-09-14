#!/bin/bash

echo "Curl: running predictions"
NAMESPACE=flowers-ns
MODEL_NAME=flowers-sample
INPUT_PATH=@./payload.json
INGRESS_GATEWAY=istio-ingressgateway

CLUSTER_IP=$(kubectl -n istio-system get service $INGRESS_GATEWAY -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
SERVICE_HOSTNAME=$(kubectl get inferenceservice $MODEL_NAME -n $NAMESPACE -o jsonpath='{.status.url}' | cut -d "/" -f 3)

curl -v -H "Host: ${SERVICE_HOSTNAME}" http://$CLUSTER_IP/v1/models/$MODEL_NAME:predict -d $INPUT_PATH

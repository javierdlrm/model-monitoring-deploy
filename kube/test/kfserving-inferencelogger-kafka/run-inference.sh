#!/bin/sh

#
# KFServing logger to Kafka
#

echo "Kubectl: serving model"
kubectl apply -f inference-service.yaml

echo "Kubectl: waiting until model is served"
kubectl wait inferenceservice/flowers-sample --for=condition=Ready --timeout=240s

echo "Curl: running predictions"
MODEL_NAME=flowers-sample
INPUT_PATH=@./payload.json
INGRESS_GATEWAY=istio-ingressgateway

CLUSTER_IP=$(kubectl -n istio-system get service $INGRESS_GATEWAY -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
SERVICE_HOSTNAME=$(kubectl get inferenceservice $MODEL_NAME -o jsonpath='{.status.url}' | cut -d "/" -f 3)

curl -v -H "Host: ${SERVICE_HOSTNAME}" http://$CLUSTER_IP/v1/models/$MODEL_NAME:predict -d $INPUT_PATH

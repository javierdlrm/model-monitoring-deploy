#!/bin/sh

#
# Knative
#

echo "Kubectl: Deleting Knative Serving component"
kubectl apply -f knative/knative-serving.yaml

echo "Kubectl: Deleting Knative Serving operator"
kubectl apply -f knative/knative-serving-operator.yaml

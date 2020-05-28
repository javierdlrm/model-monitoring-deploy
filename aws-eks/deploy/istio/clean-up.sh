#!/bin/sh

#
# Istio
#

echo "Kubectl: deleting cluster local gateway"
kubectl apply -f istio/istio-local-gateway.yaml

echo "Kubectl: deleting Istio from template"
kubectl apply -f istio/istio.yaml

echo "Kubectl: deleting namespace for Istio"
kubectl apply -f istio/istio-namespaces.yaml

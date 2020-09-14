#!/bin/sh

#
# Istio
#

echo "Kubectl: deleting cluster local gateway"
kubectl delete -f istio/istio-local-gateway.yaml

echo "Kubectl: deleting Istio from template"
kubectl delete -f istio/istio.yaml

echo "Kubectl: deleting namespace for Istio"
kubectl delete -f istio/istio-namespaces.yaml

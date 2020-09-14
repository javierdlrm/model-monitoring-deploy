#!/bin/sh

#
# Istio
#

echo "Kubectl: deleting Istio system"
kubectl delete ns istio-system

echo "Kubectl: deleting Istio operator"
kubectl delete ns istio-operator

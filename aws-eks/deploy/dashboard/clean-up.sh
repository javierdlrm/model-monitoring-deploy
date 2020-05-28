#!/bin/sh

#
# Kubernetes Dashboard
#

echo "Kubectl: Deleting roles"
kubectl delete -f dashboard/eks-admin-service-account.yaml

echo "Kubectl: Deleting kubernetes web ui crds"
kubectl delete -f dashboard/kubernetes-web-ui.yaml
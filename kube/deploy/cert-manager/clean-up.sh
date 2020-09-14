#!/bin/sh

#
# Cert manager
#

echo "Helm: uninstalling cert-manager"
helm uninstall \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager

echo "Kubectl: create namespace for Cert-Manager"
kubectl delete -f cert-manager/cert-manager-namespaces.yaml

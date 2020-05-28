#!/bin/sh

#
# Cert manager
#

echo "Helm: uninstalling cert-manager"
helm uninstall \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.15.0

echo "Kubectl: create namespace for Cert-Manager"
kubectl apply -f cert-manager/cert-manager-namespaces.yaml

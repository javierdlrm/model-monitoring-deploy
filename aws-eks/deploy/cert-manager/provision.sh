#!/bin/sh

#
# Cert-manager
#

echo "Kubectl: create namespace for Cert-Manager"
kubectl apply -f cert-manager/cert-manager-namespaces.yaml

echo "Helm: add jetstack repo"
helm repo add jetstack https://charts.jetstack.io

echo "Helm: update repos"
helm repo update

echo "Helm: installing cert-manager"
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.15.0 \
  --set installCRDs=true

echo "Kubectl: verify installation"
kubectl get pods -n cert-manager

#!/bin/sh

#
# Cert-manager
#
# version: 1.0.1

# Create namespace
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: cert-manager
  labels:
    name: cert-manager
EOF

echo "Kubectl: installing cert-manager"
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.0.1 \
  --set installCRDs=true

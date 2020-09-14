#!/bin/sh

# Install KFServing and required tools

# VERSIONS:
# Helm -> 3
# Knative -> 0.17 // latests
# Istio -> 1.7.1 // <1.6 requires Helm 2 // >1.5.2 required by Knative
# Cert-manager -> 1.0.1 // latest
# KFServing -> 0.3.0  // 0.4.0 not supported in Kubernetes 1.18

#
# Helm
#

# From script: it detects arch/os and install helm accordingly
# Optional args:
# -v | --version: define specific version
# --no-sudo: install without sudo
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Update Helm repos
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add jetstack https://charts.jetstack.io # cert-manager
helm repo update

# Istio

# Download binaries
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.7.1 sh -

# Create namespace
kubectl create ns istio-system

# Install Istio Operator
helm template istio-1.7.1/manifests/charts/istio-operator/ \
  --set hub=docker.io/istio \
  --set tag=1.7.1 \
  --set operatorNamespace=istio-operator \
  --set watchedNamespaces=istio-system | kubectl apply -f -

# Notes:
# targetPort cannot be lower than 1024.
# istioctl manifest apply not known, use install to apply manifests
cat <<EOF | istio-1.7.1/bin/istioctl manifest install -f -
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  values:
    global:
      proxy:
        autoInject: disabled
      useMCP: false
      # The third-party-jwt is not enabled on all k8s.
      # See: https://istio.io/docs/ops/best-practices/security/#configure-third-party-service-account-tokens
      jwtPolicy: first-party-jwt

  addonComponents:
    pilot:
      enabled: true
    prometheus:
      enabled: false

  components:
    ingressGateways:
      - name: istio-ingressgateway
        enabled: true
      - name: cluster-local-gateway
        enabled: true
        label:
          istio: cluster-local-gateway
          app: cluster-local-gateway
        k8s:
          service:
            type: ClusterIP
            ports:
            - port: 15020
              name: status-port
              targetPort: 15020
            - port: 80
              name: http2
              targetPort: 8080
            - port: 443
              name: https
              targetPort: 8443
EOF

#
# Knative
#

# Install knative serving operator
# Note: Only knative serving is required. (Knative eventing can be installed independently)
kubectl apply -f https://github.com/knative/operator/releases/download/v0.17.0/operator.yaml

# Install knative serving component
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
 name: knative-serving
---
apiVersion: operator.knative.dev/v1alpha1
kind: KnativeServing
metadata:
  name: knative-serving
  namespace: knative-serving
EOF

# ALTERNATIVE: for production environments concerning v0.17.0
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.17.0/serving-crds.yaml
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.17.0/serving-core.yaml
kubectl apply --filename https://github.com/knative/net-istio/releases/download/v0.17.0/release.yaml
kubectl --namespace istio-system get service istio-ingressgateway # Fetch the External IP or CNAME to configure DNS
# Configure DNS
# Note: Only work if the cluster LoadBalancer service exposes an IPv4 address or hostname
# Not working with IPv6 clusters or local setups like Minikube
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.16.0/serving-default-domain.yaml
# - Alternative for DNS: for IPv6 clusters
kubectl patch configmap/config-domain \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"knative.example.com":""}}' # Replace knative.example.com with your domain suffix

#
# Cert-manager
#

# Create namespace
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: cert-manager
  labels:
    name: cert-manager
EOF

# Install cert-manager CRDs
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.0.1 \
  --set installCRDs=true

#
# KFServing
#

# Install KFServing (v0.3.0)
# NOTE: KFServing v0.4.0 not supported with Kubernetes 1.18
kubectl apply -f kfserving.yaml

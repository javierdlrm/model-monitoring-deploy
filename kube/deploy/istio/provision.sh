#!/bin/sh

#
# Istio
#
# version: 1.7.1

# Download binaries
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.7.1 sh -

# Create namespace
kubectl create ns istio-system

# Install Istio Operator
echo "Kubectl: installing Istio operator"
helm template istio-1.7.1/manifests/charts/istio-operator/ \
  --set hub=docker.io/istio \
  --set tag=1.7.1 \
  --set operatorNamespace=istio-operator \
  --set watchedNamespaces=istio-system | kubectl apply -f -

# Install Istio without sidecar injection
# targetPort cannot be lower than 1024.
# istioctl manifest apply not known, use install to apply manifests
echo "Kubectl: installing Istio system"
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

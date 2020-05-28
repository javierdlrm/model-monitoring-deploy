#!/bin/sh

#
# Istio
#

# Download and unpack Istio
echo "Curl: Downloading Istio"
export ISTIO_VERSION=1.4.6
cd tmp; curl -L https://git.io/getLatestIstio | sh -; cd ..

echo "Kubectl: installing Istio CRDs"
for i in tmp/istio-${ISTIO_VERSION}/install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done

echo "Kubectl: creating namespace for Istio"
kubectl apply -f istio/istio-namespaces.yaml

# echo "Helm: creating yaml template for Istio"
# NOTE: Istio can be installed with or without automatic sidecar injection
# Istio with sidecar injection provides: mutual TLS (secure service-to-service traffice within the cluster) and Istio authorization policy

# A template with sidecar injection enabled.
# helm template --namespace=istio-system \
#   --set sidecarInjectorWebhook.enabled=true \
#   --set sidecarInjectorWebhook.enableNamespacesByDefault=true \
#   --set global.proxy.autoInject=disabled \
#   --set global.disablePolicyChecks=true \
#   --set prometheus.enabled=false \
#   `# Disable mixer prometheus adapter to remove istio default metrics.` \
#   --set mixer.adapters.prometheus.enabled=false \
#   `# Disable mixer policy check, since in our template we set no policy.` \
#   --set global.disablePolicyChecks=true \
#   --set gateways.istio-ingressgateway.autoscaleMin=1 \
#   --set gateways.istio-ingressgateway.autoscaleMax=2 \
#   --set gateways.istio-ingressgateway.resources.requests.cpu=500m \
#   --set gateways.istio-ingressgateway.resources.requests.memory=256Mi \
#   `# Enable SDS in the gateway to allow dynamically configuring TLS of gateway.` \
#   `#   --set gateways.istio-ingressgateway.sds.enabled=true` \
#   `# More pilot replicas for better scale` \
#   --set pilot.autoscaleMin=2 \
#   `# Set pilot trace sampling to 100%` \
#   --set pilot.traceSampling=100 \
#   tmp/istio-${ISTIO_VERSION}/install/kubernetes/helm/istio \
#   > ./istio/istio.yaml

echo "Kubectl: installing Istio from template"
kubectl apply -f istio/istio.yaml

echo "Kubectl: check Istio components"
kubectl get pods --namespace istio-system

# echo "Helm: creating yaml template for cluster local gateway"
# Update install to use cluster local gateway
# helm template --namespace=istio-system \
#   --set gateways.custom-gateway.autoscaleMin=1 \
#   --set gateways.custom-gateway.autoscaleMax=2 \
#   --set gateways.custom-gateway.cpu.targetAverageUtilization=60 \
#   --set gateways.custom-gateway.labels.app='cluster-local-gateway' \
#   --set gateways.custom-gateway.labels.istio='cluster-local-gateway' \
#   --set gateways.custom-gateway.type='ClusterIP' \
#   --set gateways.istio-ingressgateway.enabled=false \
#   --set gateways.istio-egressgateway.enabled=false \
#   --set gateways.istio-ilbgateway.enabled=false \
#   --set global.mtls.auto=false \
#   tmp/istio-${ISTIO_VERSION}/install/kubernetes/helm/istio \
#   -f tmp/istio-${ISTIO_VERSION}/install/kubernetes/helm/istio/example-values/values-istio-gateways.yaml \
#   | sed -e "s/custom-gateway/cluster-local-gateway/g" -e "s/customgateway/clusterlocalgateway/g" \
#   > ./istio/istio-local-gateway.yaml

echo "Kubectl: installing cluster local gateway"
kubectl apply -f istio/istio-local-gateway.yaml

# NOTE: DNS configuration?

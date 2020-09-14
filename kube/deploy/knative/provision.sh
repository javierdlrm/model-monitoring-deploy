#!/bin/sh

#
# Knative
#
# version: 0.17
# note: Knative Serving and Eventing can be deployed independently. Only serving is required by KFServing

echo "Kubectl: installing Knative operator"
kubectl apply -f https://github.com/knative/operator/releases/download/v0.17.0/operator.yaml

#
# Knative Serving
#

if [ $# -eq 0 ] || [ "$1" = "serving" ]; then

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

fi

#
# Knative Eventing (operator)
#

if [ $# -eq 0 ] || [ "$1" = "eventing" ]; then

    cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
 name: knative-eventing
---
apiVersion: operator.knative.dev/v1alpha1
kind: KnativeEventing
metadata:
  name: knative-eventing
  namespace: knative-eventing
EOF

fi

#
# Knative Monitoring
#
# Install in a second step with 'monitoring' parameter

if [ $# -eq 1 ] && [ "$1" = "monitoring" ]; then

    echo "Manual step: Add 'metrics.request-metrics-backend-destination: prometheus' to data field."
    kubectl edit cm -n knative-serving config-observability

    echo "Kubectl: installing Knative monitoring with prometheus"
    kubectl apply --filename https://github.com/knative/serving/releases/download/v0.17.0/monitoring-metrics-prometheus.yaml

    echo "Kubectl: installing ElasticSearch and Kibana"
    kubectl apply --filename https://github.com/knative/serving/releases/download/v0.17.0/monitoring-logs-elasticsearch.yaml

fi

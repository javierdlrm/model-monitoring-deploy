#!/bin/sh

#
# Knative
#

if [ $# -eq 1 ] && [ "$1" = "monitoring" ]; then

    echo "Kubectl: deleting Elastic Search and Kibana"
    kubectl apply --filename https://github.com/knative/serving/releases/download/v0.17.0/monitoring-logs-elasticsearch.yaml

    echo "Kubectl: deleting Knative monitoring"
    kubectl apply --filename https://github.com/knative/serving/releases/download/v0.17.0/monitoring-metrics-prometheus.yaml

fi

if [ $# -eq 1 ] && [ "$1" = "eventing" ]; then

    echo "Kubectl: Deleting Knative Eventing component"
    kubectl delete KnativeEventing knative-eventing -n knative-eventing

fi

if [ $# -eq 1 ] && [ "$1" = "serving" ]; then

    echo "Kubectl: deleting Knative Serving component"
    kubectl delete KnativeServing knative-serving -n knative-serving

fi

echo "Kubectl: deleting Knative operator"
kubectl delete -f https://github.com/knative/operator/releases/download/v0.17.0/operator.yaml

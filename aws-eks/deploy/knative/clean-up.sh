#!/bin/sh

#
# Knative
#

echo "Kubectl: Deleting Jaeger"
kubectl delete -f knative/monitoring-tracing-jaeger.yaml

echo "Kubectl: Deleting Elasticsearch"
kubectl delete --filename https://github.com/knative/serving/releases/download/v0.14.0/monitoring-logs-elasticsearch.yaml

echo "Kubectl: Deleting Knative Monitoring"
kubectl delete --filename https://github.com/knative/serving/releases/download/v0.14.0/monitoring-metrics-prometheus.yaml

echo "Kubectl: Deleting monitoring core"
kubectl delete --filename https://github.com/knative/serving/releases/download/v0.14.0/monitoring-core.yaml

echo "Kubectl: Deleting Knative Serving component"
kubectl delete -f knative/serving-component.yaml

echo "Kubectl: Deleting Knative Serving operator"
kubectl delete -f knative/serving-operator.yaml

echo "Kubectl: Deleting Knative Eventing component"
kubectl delete -f knative/eventing-component.yaml

echo "Kubectl: Deleting Knative Eventing operator"
kubectl delete -f knative/eventing-operator.yaml

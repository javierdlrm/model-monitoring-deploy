#!/bin/sh

#
# Knative Serving (operator)
#

echo "Kubectl: installing Knative Serving operator"
kubectl apply -f knative/serving-operator.yaml

echo "Kubectl: verify installation"
kubectl get deployment knative-serving-operator

echo "Kubectl: track logs"
kubectl logs -f $(kubectl get pods -l name=knative-serving-operator -o name)

echo "Kubectl: installing Knative Serving component"
kubectl apply -f knative/serving-component.yaml

echo "Kubectl: verify installation"
kubectl get deployment -n knative-serving

#
# Knative Eventing (operator)
#

echo "Kubectl: installing Knative Serving operator"
kubectl apply -f knative/eventing-operator.yaml

echo "Kubectl: verify installation"
kubectl get deployment knative-eventing-operator

echo "Kubectl: track logs"
kubectl logs -f $(kubectl get pods -l name=knative-eventing-operator -o name)

echo "Kubectl: installing Knative Serving component"
kubectl apply -f knative/eventing-component.yaml

echo "Kubectl: verify installation"
kubectl get deployment -n knative-eventing

#
# Knative Monitoring
#

echo "Kubectl: installing monitoring core"
kubectl apply -f knative/monitoring-core.yaml

echo "Kubectl: installing Knative Monitoring"
kubectl apply -f knative/monitoring-metrics-prometheus.yaml

echo "Kubectl: installing Elasticsearch"
kubectl apply -f knative/monitoring-logs-elasticsearch.yaml
# Manually: Navigate to the Kibana UI. It might take a couple of minutes for the proxy to work.
# Within the “Configure an index pattern” page, enter logstash-* to Index pattern and select @timestamp from Time Filter field name and click on Create button.

echo "Kubectl: installing Jaeger"
kubectl apply -f knative/monitoring-tracing-jaeger.yaml
# Manually: Open Kibana UI as described in Create Elasticsearch Indices section.
# Select Create Index Pattern button on top left of the page. Enter jaeger* to Index pattern and select timestamp_millis from Time Filter field name and click on Create button.

# Grafana UI
kubectl port-forward --namespace knative-monitoring \
    $(kubectl get pods --namespace knative-monitoring \
        --selector=app=grafana --output=jsonpath="{.items..metadata.name}") \
    3000

echo "Grafana: http://localhost:3000/"
echo "Kibana: http://localhost:8001/api/v1/namespaces/knative-monitoring/services/kibana-logging/proxy/app/kibana"
echo "Jager: http://localhost:8001/api/v1/namespaces/istio-system/services/jaeger-query:16686/proxy/search/"

 kubectl get secret \
    --namespace knative-monitoring grafana \
    -o jsonpath="{.data.admin-password}" \
    | base64 --decode ; echo
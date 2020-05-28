#!/bin/sh

#
# Kafka (strimzi)
#

echo "Kubectl: Creating namespaces for Kafka"
kubectl create -f kafka/kafka-namespaces.yaml

echo "Helm: adding strimzi charts"
helm repo add strimzi http://strimzi.io/charts

echo "Helm: search kafka operator available"
helm search repo strimzi

echo "Helm: installing kafka operator"
helm install kafka strimzi/strimzi-kafka-operator -n kafka-operator

echo "Kubectl: deploy kafka cluster"
kubectl apply -f kafka/kafka-cluster.yaml -n kafka-operator

echo "Kubectl: waiting until kafka-cluster is ready"
kubectl wait kafka/kafka-cluster --for=condition=Ready --timeout=240s -n kafka-operator

echo "Kubectl: check created resources"
kubectl get statefulsets.apps,pod,deployments,svc -n kafka-operator

# NOTE: Pods accessible via:
# - Same namespace: $(podname).$(governing service domain) e.g. kafka-cluster-kafka-0.kafka-cluster-kafka-brokers
# - Different namespace: $(podname).$(service name).$(namespace).svc.cluster.local
# - Service: kafka-cluster-kafka-bootstrap:9092

#!/bin/sh

#
# Kafka (strimzi)
#

echo "Kubectl: delete kafka cluster"
kubectl delete -f kafka/kafka-cluster.yaml -n kafka-operator

echo "Kubectl: Deleting namespaces for Kafka"
kubectl delete -f kafka/kafka-namespaces.yaml

echo "Helm: uninstalling kafka operator"
helm install kafka strimzi/strimzi-kafka-operator -n kafka-operator

# # Delete the Strimzi cluster operator
# kubectl delete strimzi-cluster-operator

# # Manually delete the persistent volumes
# # Kafka
# kubectl delete pvc data-kafka-cluster-kafka-0
# kubectl delete pvc data-kafka-cluster-kafka-1

# # Zookeeper
# kubectl delete pvc data-kafka-cluster-zookeeper-0
# kubectl delete pvc data-kafka-cluster-zookeeper-1

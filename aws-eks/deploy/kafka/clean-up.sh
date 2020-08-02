#!/bin/sh

#
# Kafka (strimzi)
#

echo "Kubectl: delete kafka cluster"
kubectl delete -f kafka/kafka-cluster.yaml -n kafka-operator

echo "Kubectl: Deleting namespaces for Kafka"
kubectl delete -f kafka/kafka-namespaces.yaml

echo "Helm: uninstalling kafka operator"
# helm delete kafka strimzi/strimzi-kafka-operator -n kafka-operator

# # Delete the Strimzi cluster operator
# kubectl delete strimzi-cluster-operator

# # Manually delete the persistent volumes
# # Kafka
# kubectl delete pvc data-kafka-cluster-kafka-0
# kubectl delete pvc data-kafka-cluster-kafka-1

# # Zookeeper
# kubectl delete pvc data-kafka-cluster-zookeeper-0
# kubectl delete pvc data-kafka-cluster-zookeeper-1

# # CRDs
kubectl delete crd kafkabridges.kafka.strimzi.io
kubectl delete crd kafkaconnectors.kafka.strimzi.io
kubectl delete crd kafkaconnects.kafka.strimzi.io
kubectl delete crd kafkaconnects2is.kafka.strimzi.io
kubectl delete crd kafkamirrormaker2s.kafka.strimzi.io
kubectl delete crd kafkamirrormakers.kafka.strimzi.io
kubectl delete crd kafkarebalances.kafka.strimzi.io
kubectl delete crd kafkas.kafka.strimzi.io
kubectl delete crd kafkatopics.kafka.strimzi.io
kubectl delete crd kafkausers.kafka.strimzi.io

# ClusterRoles
kubectl delete clusterrole strimzi-cluster-operator-global
kubectl delete clusterrole strimzi-cluster-operator-namespaced
kubectl delete clusterrole strimzi-entity-operator
kubectl delete clusterrole strimzi-kafka-broker
kubectl delete clusterrole strimzi-topic-operator

# ClusterRoleBindings
kubectl delete clusterrolebinding strimzi-cluster-operator
kubectl delete clusterrolebinding strimzi-cluster-operator-kafka-broker-delegation

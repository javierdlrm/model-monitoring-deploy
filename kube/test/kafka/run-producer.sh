#!/bin/sh

#
# Kafka test (producer)
#

echo "Kubectl: creating test-topic"
kubectl apply -f kafka-topic.yaml -n kafka-operator

echo "Kubectl: Producer: writing to a topic (automatically created)"
kubectl -n kafka-operator run kafka-producer -ti --image=strimzi/kafka:0.17.0-kafka-2.4.0 --rm=true --restart=Never -- bin/kafka-console-producer.sh --broker-list kafka-cluster-kafka-bootstrap:9092 --topic test-topic

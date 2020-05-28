#!/bin/sh

#
# Kafka test (consumer)
#

echo "Kubectl: Consumer: reading from topic"
kubectl -n kafka-operator run kafka-consumer -ti --image=strimzi/kafka:0.17.0-kafka-2.4.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server kafka-cluster-kafka-bootstrap:9092 --topic test-topic --from-beginning

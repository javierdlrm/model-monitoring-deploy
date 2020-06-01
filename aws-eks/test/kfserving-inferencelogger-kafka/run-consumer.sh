#!/bin/sh

#
# KFServing logger to Kafka
#

echo "Kubectl: creating test-topic"
kubectl apply -f kafka-topic.yaml -n kafka-operator

echo "Kubectl: Consumer: reading from topic"
KAFKA_TOPIC=test-topic
KAFKA_BROKER=kafka-cluster-kafka-bootstrap:9092
kubectl -n kafka-operator run kafka-consumer -ti --image=strimzi/kafka:0.17.0-kafka-2.4.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server $KAFKA_BROKER --topic $KAFKA_TOPIC --from-beginning

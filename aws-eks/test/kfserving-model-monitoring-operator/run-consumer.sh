#!/bin/bash

#
# Consume Kafka topic
#

if [ $# -eq 0 ]; then
    echo "Topic name must be specified"
fi

echo "Kubectl: Consumer: reading from: $1"
KAFKA_TOPIC=$1
KAFKA_BROKER=kafka-cluster-kafka-bootstrap:9092
kubectl -n kafka-operator run kafka-consumer -ti --image=strimzi/kafka:0.17.0-kafka-2.4.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server $KAFKA_BROKER --topic $KAFKA_TOPIC --from-beginning

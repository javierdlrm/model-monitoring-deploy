#!/bin/bash

#
# Overview of main components
#

printf "\n#\n# Model Monitors\n#\n\n"
kubectl get modelmonitors --all-namespaces

printf "\n#\n# Flowers-ns pods\n#\n\n"
kubectl get pods -n flowers-ns

printf "\n#\n# Spark Applications\n#\n\n"
kubectl get sparkapplications --all-namespaces

printf "\n#\n# Kafka topics\n#\n\n"
kubectl get kafkatopics -n kafka-operator

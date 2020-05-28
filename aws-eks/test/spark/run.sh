#!/bin/sh

#
# Spark test
#

echo "Kubectl: Spark: running spark-pi job"
kubectl apply -f spark-pi.yaml -n spark-apps

echo "Kubectl: describe job"
kubectl describe sparkapplications --all-namespaces
kubectl describe sparkapplications spark-pi -n spark-apps

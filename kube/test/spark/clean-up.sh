#!/bin/sh

#
# Spark test
#

echo "Kubectl: Deleting spark-pi job"
kubectl delete -f spark-pi.yaml -n spark-apps

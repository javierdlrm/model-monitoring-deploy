#!/bin/sh

#
# Metrics server
#

echo "Kubectl: Deleting metrics-server"
kubectl delete -f metrics-server/metrics-server.yaml

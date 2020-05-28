#!/bin/sh

#
# Metrics-server
#

echo "Kubectl: installing metrics-server"
kubectl apply -f metrics-server/metrics-server.yaml

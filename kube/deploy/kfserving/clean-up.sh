#!/bin/sh

#
# KFServing
#

echo "Kubectl: Deleting kfserving"
kubectl delete -f kfserving/kfserving.yaml

sleep 6s
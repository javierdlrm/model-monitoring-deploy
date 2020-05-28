#!/bin/sh

#
# KFServing test
#

echo "Kubectl: Deleting model"
kubectl delete -f inference-service.yaml

#!/bin/bash

#
# Descheduler
#

echo "Kubectl: deleting Descheduler"
kubectl delete -f descheduler/job.yaml
kubectl delete -f descheduler/configmap.yaml
kubectl delete -f descheduler/rbac.yaml

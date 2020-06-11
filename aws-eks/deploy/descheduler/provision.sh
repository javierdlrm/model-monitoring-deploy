#!/bin/bash

#
# Descheduler
#

echo "Kubectl: installing Descheduler"
kubectl create -f descheduler/rbac.yaml
kubectl create -f descheduler/configmap.yaml
kubectl create -f descheduler/job.yaml

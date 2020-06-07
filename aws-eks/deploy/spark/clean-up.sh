#!/bin/sh

#
# Spark
#

echo "Kubectl: Deleting namespaces for Spark"
kubectl delete -f spark/spark-namespaces.yaml

# echo "Kubectl: Deleting clusterrolebinding"
kubectl delete clusterrolebinding spark-sparkoperator-crb

# echo "Kubectl: Deleting clusterrole"
kubectl delete clusterrole spark-sparkoperator-cr

# echo "Kubectl: Deleting CRDs"
kubectl delete crd sparkapplications.sparkoperator.k8s.io
kubectl delete crd scheduledsparkapplications.sparkoperator.k8s.io
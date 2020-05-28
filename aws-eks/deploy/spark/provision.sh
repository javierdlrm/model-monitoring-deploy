#!/bin/sh

#
# Spark
#

echo "Kubectl: Creating namespaces for Spark"
kubectl create -f spark/spark-namespaces.yaml

echo "Helm: update repos"
helm repo update

echo "Helm: adding spark operator incubator charts"
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator

echo "Heml: installing spark operator"
helm install spark incubator/sparkoperator --namespace spark-operator --set sparkJobNamespace=spark-apps,logLevel=3,serviceAccounts.spark.name=spark

echo "Kubectl: Waiting until spark is ready"
# kubectl wait _ --for=condition=Ready --timeout=240s -n spark-operator
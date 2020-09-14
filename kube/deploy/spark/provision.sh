#!/bin/sh

#
# Spark
#

echo "Kubectl: Creating namespaces for Spark"
kubectl create -f spark/spark-namespaces.yaml

# Not needed when installing with Helm and specifying sparkJobNamespace,
# otherwise rbac is required on the namespace where a spark application is deployed.
echo "Kubectl: Create rbac"
kubectl create -f spark/spark-rbac.yaml # enable rbac in default namespace

echo "Helm: update repos"
helm repo update

echo "Helm: adding spark operator incubator charts"
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator

echo "Heml: installing spark operator"
# helm install spark incubator/sparkoperator --namespace spark-operator --set sparkJobNamespace=spark-apps,logLevel=3,serviceAccounts.spark.name=spark
helm install spark incubator/sparkoperator --namespace spark-operator --set logLevel=3,serviceAccounts.spark.name=spark # requires spark-rbac.yaml

echo "Kubectl: Waiting until spark is ready"
kubectl wait _ --for=condition=Ready --timeout=240s -n spark-operator

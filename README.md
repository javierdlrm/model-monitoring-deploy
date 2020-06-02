# Model-monitoring-deploy
Scripts, configuration files and tests for the deployment of model-monitoring-operator on a kubernetes cluster.

> **Note**: Some customization might be required. Use them as a guide instead of for automating the deployment.

## Deploy

The scripts includes the following services

* Cert-manager
* Istio
* Knative
* KFServing
* Kafka ([strimzi](https://github.com/strimzi/strimzi-kafka-operator))
* Spark ([spark-on-k8s-operator](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator))
* Kubernetes dashboard
* Metrics-server

## Test

Simple tests to check if the services work as expected are included for cert-manager, Kafka, Spark and KFServing.

Other integration tests available are:

* KFServing with [inference-logger](https://github.com/javierdlrm/inference-logger) and Kafka
* KFServing with the [model-monitoring operator](https://github.com/javierdlrm/model-monitoring-operator)


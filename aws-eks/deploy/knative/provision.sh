#!/bin/sh

#
# Knative Serving (operator)
#

echo "Kubectl: installing Knative Serving operator"
kubectl apply -f knative/knative-serving-operator.yaml

echo "Kubectl: verify installation"
kubectl get deployment knative-serving-operator

echo "Kubectl: track logs"
kubectl logs -f $(kubectl get pods -l name=knative-serving-operator -o name)

echo "Kubectl: installing Knative Serving component"
kubectl apply -f knative/knative-serving.yaml

echo "Kubectl: verify installation"
kubectl get deployment -n knative-serving

#
# Knative Eventing (operator)
#

# echo "Kubectl: installing Knative Serving operator"
# kubectl apply -f https://github.com/knative/eventing-operator/releases/download/v0.14.0/eventing-operator.yaml

# echo "Kubectl: verify installation"
# kubectl get deployment knative-eventing-operator

# echo "Kubectl: track logs"
# kubectl logs -f $(kubectl get pods -l name=knative-eventing-operator -o name)

# echo "Kubectl: installing Knative Serving component"
# kubectl apply -f knative/knative-eventing.yaml

# echo "Kubectl: verify installation"
# kubectl get deployment -n knative-eventing

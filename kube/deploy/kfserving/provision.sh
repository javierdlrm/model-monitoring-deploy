#!/bin/sh

#
# KFServing
#
# version: 0.3.0
# note: KFServing v0.4.0 not supported with Kubernetes 1.18

echo "Kubectl: installing KFServing"
kubectl apply -f kfserving.yaml

# Only for Kubernetes < v1.16
# echo "Kubectl: turn on object selector (so only InferenceService pods go through the pod mutator)"
# kubectl patch mutatingwebhookconfiguration inferenceservice.serving.kubeflow.org --patch '{"webhooks":[{"name": "inferenceservice.kfserving-webhook-server.pod-mutator","objectSelector":{"matchExpressions":[{"key":"serving.kubeflow.org/inferenceservice", "operator": "Exists"}]}}]}'

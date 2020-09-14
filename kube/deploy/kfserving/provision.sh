#!/bin/sh

#
# KFServing
#

echo "Kubectl: installing KFServing"
kubectl apply -f kfserving/kfserving.yaml

echo "Kubectl: turn on object selector (so only InferenceService pods go through the pod mutator)"
kubectl patch mutatingwebhookconfiguration inferenceservice.serving.kubeflow.org --patch '{"webhooks":[{"name": "inferenceservice.kfserving-webhook-server.pod-mutator","objectSelector":{"matchExpressions":[{"key":"serving.kubeflow.org/inferenceservice", "operator": "Exists"}]}}]}'

sleep 6s

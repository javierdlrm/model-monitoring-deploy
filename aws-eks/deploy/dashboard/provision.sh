#!/bin/sh

#
# Kubernetes Web UI
#

echo "Kubectl: install kubernetes webui crds"
kubectl apply -f dashboard/kubernetes-web-ui.yaml

echo "Kubectl: apply roles"
kubectl apply -f dashboard/eks-admin-service-account.yaml

# echo "Kubectl: obtain token"
# kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')

# echo "Kubectl: start proxy"
# kubectl proxy

# echo "Access via: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/login"

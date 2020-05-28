#!/bin/sh

eksctl get cluster
CLUSTER_NAME=javier-eks-model-monitoring-cluster

eksctl get nodegroup --cluster $CLUSTER_NAME
NODEGROUP_NAME=standard-workers

echo "Eksctl: drain nodes"
eksctl drain nodegroup --cluster=$CLUSTER_NAME --name=$NODEGROUP_NAME

echo "Eksctl: undo drain"
eksctl drain nodegroup --cluster=$CLUSTER_NAME --name=$NODEGROUP_NAME --undo

echo "Eksctl: downscaling cluster"
eksctl scale nodegroup --cluster=$CLUSTER_NAME --name=$NODEGROUP_NAME --nodes=1

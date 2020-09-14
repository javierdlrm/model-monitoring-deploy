#!/bin/sh

# Check cluster: eksctl get cluster

if [ $# -ne 1 ]; then
    echo "Parameters required: downscale-cluster.sh <cluster_name>"
fi

CLUSTER_NAME=$1
NODEGROUP_NAME=standard-workers

eksctl get nodegroup --cluster $CLUSTER_NAME

echo "Eksctl: drain nodes"
eksctl drain nodegroup --cluster=$CLUSTER_NAME --name=$NODEGROUP_NAME

echo "Eksctl: undo drain"
eksctl drain nodegroup --cluster=$CLUSTER_NAME --name=$NODEGROUP_NAME --undo

echo "Eksctl: downscaling cluster"
eksctl scale nodegroup --cluster=$CLUSTER_NAME --name=$NODEGROUP_NAME --nodes=1

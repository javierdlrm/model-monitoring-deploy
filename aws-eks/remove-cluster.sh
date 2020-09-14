#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Parameters required: remove-cluster.sh <cluster_name>"
fi

CLUSTER_NAME=$1

echo "Eksctl: deleting cluster"
eksctl delete cluster $CLUSTER_NAME

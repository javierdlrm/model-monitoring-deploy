#!/bin/sh

#
# AWS CLI
#
# Creates a managed EKS cluster with 3 nodes t3.medium with kubernetes 1.16

if [ $# -ne 3 ]; then
    echo "Parameters required: create-cluster.sh <cluster_name> <region_name> <ssh_public_key_path>"
fi

REGION_NAME=$1
CLUSTER_NAME=$2
SSH_PUBLIC_KEY_PATH=$3

# Install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure aws: Access Key, Access secret, region and output format.
aws configure

#
# EKSCTL
#

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# Permissions required

eksctl create cluster \
    --name $CLUSTER_NAME \
    --version 1.16 \
    --region $REGION_NAME \
    --nodegroup-name standard-workers \
    --node-type t3.medium \
    --nodes 3 \
    --nodes-min 1 \
    --nodes-max 4 \
    --ssh-access \
    --ssh-public-key $SSH_PUBLIC_KEY_PATH \
    --managed

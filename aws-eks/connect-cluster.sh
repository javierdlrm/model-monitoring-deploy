#!/bin/sh

#
# AWS CLI
#

if [ $# -ne 2 ]; then
    echo "Parameters required: connect-cluster.sh <region_name> <cluster_name>"
fi

REGION_CODE=$1
CLUSTER_NAME=$2

# Install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure aws: Access Key, Access secret, region and output format.
aws configure

# Configure Kubectl config file with aws cli
aws eks --region $REGION_CODE update-kubeconfig --name $CLUSTER_NAME

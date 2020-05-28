#!/bin/sh

#
# AWS CLI
#

# Install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure aws: Access Key, Access secret, region and output format.
aws configure

# Configure Kubectl config file with aws cli

REGION_CODE=eu-north-1
CLUSTER_NAME=javier-eks-model-monitoring-cluster

aws eks --region $REGION_CODE update-kubeconfig --name $CLUSTER_NAME

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

#
# EKSCTL
#

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# Permissions required

eksctl create cluster \
--name model-monitoring-cluster \
--version 1.16 \
--region eu-central-1 \
--nodegroup-name standard-workers \
--node-type t3.medium \
--nodes 3 \
--nodes-min 1 \
--nodes-max 4 \
--ssh-access \
--ssh-public-key /home/javierdlrm/.ssh/eks_rsa.pub \
--managed

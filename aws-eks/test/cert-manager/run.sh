#!/bin/sh

#
# Cert-Manager
#

kubectl apply -f cert-manager-issuer.yaml

kubectl describe certificate -n cert-manager-test
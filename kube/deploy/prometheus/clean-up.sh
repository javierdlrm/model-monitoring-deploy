#!/bin/bash

kubectl delete -f prometheus/prometheus-knative-servicemonitors.yaml

kubectl delete --ignore-not-found=true -f prometheus/manifests/ -f prometheus/manifests/setup

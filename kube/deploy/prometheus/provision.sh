#!/bin/bash

# Setup

kubectl create ns monitoring

kubectl create -f prometheus/monitoring/prometheus-setup/prometheus-operator-service-account.yaml -n monitoring

kubectl create -f prometheus/monitoring/prometheus-setup/prometheus-operator-cluster-role.yaml -n monitoring

kubectl create -f prometheus/monitoring/prometheus-setup/prometheus-operator-cluster-role-binding.yaml -n monitoring

kubectl create -f prometheus/monitoring/prometheus-setup/prometheus-operator-deployment.yaml -n monitoring

# Strimzi service monitor

kubectl apply -f prometheus/monitoring/strimzi-service-monitor.yaml -n monitoring
kubectl apply -f prometheus/monitoring/prometheus-rules.yaml -n monitoring

# Scrape configs

kubectl create secret generic additional-scrape-configs --from-file=prometheus/monitoring/prometheus-additional.yaml -n monitoring

# Prometheus server

kubectl apply -f prometheus/monitoring/prometheus.yaml -n monitoring

# Grafana

kubectl apply -f prometheus/monitoring/grafana.yaml -n monitoring

# Proxy

kubectl port-forward prometheus-prometheus-0 9090:9090 -n monitoring
kubectl port-forward grafana-85d856cf58-s5m4g 3000:3000 -n monitoring

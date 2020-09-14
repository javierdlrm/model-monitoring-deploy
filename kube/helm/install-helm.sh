#
# Helm
#

# From script: it detects arch/os and install helm accordingly
# Optional args:
# -v | --version: define specific version
# --no-sudo: install without sudo
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Update Helm repos
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add jetstack https://charts.jetstack.io # cert-manager
helm repo update

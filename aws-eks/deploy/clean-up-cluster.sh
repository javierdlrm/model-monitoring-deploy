#!/bin/sh

#
# Spark
#

./spark/clean-up.sh

#
# Kafka
#

./kafka/clean-up.sh

#
# Istio
#

./istio/clean-up.sh

#
# Knative
#

./knative/clean-up.sh

#
# Cert-manager
#

./cert-manager/clean-up.sh

#
# KFServing
#

./kfserving/clean-up.sh

#
# Metrics-server
#

./metrics-server/clean-up.sh

#
# Kubernetes Web UI
#

./dashboard/clean-up.sh
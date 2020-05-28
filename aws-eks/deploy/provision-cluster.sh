#!/bin/sh

#
# Spark
#

./spark/provision.sh

#
# Kafka (strimzi)
#

./kafka/provision.sh

#
# Istio
#

./istio/provision.sh

#
# Knative
#

./knative/provision.sh

#
# Cert-manager
#

./cert-manager/provision.sh

#
# KFServing
#

./kfserving/provision.sh

#
# Metrics-server
#

./metrics-server/provision.sh

#
# Kubernetes Web UI
#

./dashboard/provision.sh

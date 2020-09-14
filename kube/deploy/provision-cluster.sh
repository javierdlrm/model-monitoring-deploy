#!/bin/sh

#
# Knative
#

# Optional parameter: provision.sh serving|eventing
if [ $# -eq 1 ] && [ "$1" = "kfserving-only" ]; then
    ./knative/provision.sh serving # only serving is required by KFServing
else
    ./knative/provision.sh
fi

#
# Istio
#

./istio/provision.sh

#
# Cert-manager
#

./cert-manager/provision.sh

#
# KFServing
#

./kfserving/provision.sh

# kfserving-only ends here
if [ $# -eq 1 ] && [ "$1" = "kfserving-only" ]; then
    exit 0
fi

exit 1

#
# Spark
#

./spark/provision.sh

#
# Kafka (strimzi)
#

./kafka/provision.sh

#
# Descheduler
#
# Tool for de-scheduling pods given a set of policies, hoping Kubernetes scheduler to balance load among nodes when re-scheduling the pods

./descheduler/provision.sh

#
# Metrics-server
#

./metrics-server/provision.sh

#
# Kubernetes Web UI
#

./dashboard/provision.sh

#!/bin/sh

if [ $# -eq 0 ] || ! [ "$1" = "kfserving-only" ]; then

    #
    # Metrics-server
    #

    ./metrics-server/clean-up.sh

    #
    # Kubernetes Web UI
    #

    ./dashboard/clean-up.sh

    #
    # Descheduler
    #

    ./descheduler/clean-up.sh

    #
    # Spark
    #

    ./spark/clean-up.sh

    #
    # Kafka
    #

    ./kafka/clean-up.sh

fi

#
# KFServing
#

./kfserving/clean-up.sh

#
# Knative
#

if [ $# -eq 1 ] && [ "$1" = "kfserving-only" ]; then
    ./knative/clean-up.sh serving
else
    ./knative/clean-up.sh
fi

#
# Istio
#

./istio/clean-up.sh

#
# Cert-manager
#

./cert-manager/clean-up.sh

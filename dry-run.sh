#!/bin/bash

echo "docker hub secret: $DOCKER_HUB_SECRET"

helm install --dry-run --set docker_hub_secret=$DOCKER_HUB_SECRET --debug helm-test-chart ./charts/helm-test-chart/

#!/bin/bash
set -e

ARGUMENT_LIST=(
  "environment"
  "region"
  "cluster"
  "variants"
  "cluster-type"
  "application"
)

UUID=$(uuidgen)


# read arguments
opts=$(getopt \
  --longoptions "$(printf "%s:," "${ARGUMENT_LIST[@]}")" \
  --name "$(basename "$0")" \
  --options "" \
  -- "$@"
)

eval set --$opts

while [[ $# -gt 0 ]]; do
  case "$1" in
    --environment)
      ENVIRONMENT=$2
      shift 2
      ;;

    --cluster)
      CLUSTER=$2
      shift 2
      ;;

    --region)
      REGION=$2
      shift 2
      ;;

    --variants)
      VARIANTS=$2
      shift 2
      ;;

    --cluster-type)
      CLUSTER_TYPE=$2
      shift 2
      ;;

    --application)
      APPLICATION=$2
      shift 2
      ;;

    *)
      break
      ;;
  esac
done

echo "ENVIRONMENT $ENVIRONMENT"
echo "CLUSTER $CLUSTER"
echo "REGION $REGION"
echo "VARIANTS $VARIANTS"
echo "CLUSTER_TYPE $CLUSTER_TYPE"
echo "APPLICATION $APPLICATION"

mkdir -p ../tmp/$UUID

cp -r charts/$CLUSTER_TYPE/$APPLICATION/* ../tmp/$UUID

cp common/values.yaml ../tmp/$UUID/common-values.yaml
cp region/$REGION/values.yaml ../tmp/$UUID/$REGION-values.yaml
cp variants/$VARIANTS/values.yaml ../tmp/$UUID/$VARIANTS-values.yaml

if [[ -z "${CLUSTER}" ]]; then
  cp env/$ENVIRONMENT/$APPLICATION/values.yaml ../tmp/$UUID/$ENVIRONMENT-$APPLICATION-values.yaml
else
  cp env/$ENVIRONMENT/$CLUSTER/values.yaml ../tmp/$UUID/$ENVIRONMENT-$CLUSTER-values.yaml
fi

helm package ../tmp/$UUID/


helm install --dry-run \
--set docker_hub_secret=$DOCKER_HUB_SECRET \
--debug $APPLICATION ../tmp/$UUID/ --values ../tmp/$UUID/common-values.yaml --values ../tmp/$UUID/$REGION-values.yaml --values ../tmp/$UUID/$VARIANTS-values.yaml --values ../tmp/$UUID/$ENVIRONMENT-$APPLICATION-values.yaml

helm repo index --url https://tatroc.github.io/helm-package-example/ .
cat index.yaml
git add .
git commit -m 'new helm package'
git push



#!/bin/bash
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

cp region/$REGION/values.yaml ../tmp/$UUID/$REGION-values.yaml
cp variants/$VARIANTS/values.yaml ../tmp/$UUID/$VARIANTS-values.yaml
cp env/$ENVIRONMENT/$CLUSTER/values.yaml ../tmp/$UUID/$ENVIRONMENT-$CLUSTER-values.yaml

helm package ../tmp/$UUID/


helm repo index --url https://tatroc.github.io/helm-package-example/ .
cat index.yaml
git add .
git commit -m 'new helm package'
git push
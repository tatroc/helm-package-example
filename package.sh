#!/bin/bash
set -e

ARGUMENT_LIST=(
  "environment"
  "region"
  "cluster"
  "variants"
  "cluster-type"
  "application"
  "stage-files"
)

#UUID=$(uuidgen)


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

    --stage-files)
      STAGE_FILES=$2
      shift 2
      ;;

    *)
      break
      ;;
  esac
done

echo "ENVIRONMENT:  $ENVIRONMENT"
echo "CLUSTER:      $CLUSTER"
echo "REGION:       $REGION"
echo "VARIANTS:     $VARIANTS"
echo "CLUSTER_TYPE: $CLUSTER_TYPE"
echo "APPLICATION:  $APPLICATION"
echo "STAGE_FILES:  $STAGE_FILES"


stage_files () {

  
    echo "stage():: staging files"

    mkdir -p ./tmp/$MY_UUID

    cp -r charts/$CLUSTER_TYPE/$APPLICATION/* ./tmp/$MY_UUID

    cp common/values.yaml ./tmp/$MY_UUID/common-values.yaml
    cp region/$REGION/values.yaml ./tmp/$MY_UUID/$REGION-values.yaml
    cp variants/$VARIANTS/values.yaml ./tmp/$MY_UUID/$VARIANTS-values.yaml

    if [[ -z "${CLUSTER}" ]]; then
      cp env/$ENVIRONMENT/$APPLICATION/values.yaml ./tmp/$MY_UUID/$ENVIRONMENT-$APPLICATION-values.yaml
    else
      cp env/$ENVIRONMENT/$CLUSTER/values.yaml ./tmp/$MY_UUID/$ENVIRONMENT-$CLUSTER-values.yaml
    fi

}

if [[ "$STAGE_FILES" == "yes" ]]; then

  stage_files
  exit 0
fi

stage_files


ls -la ./tmp/$MY_UUID/
pwd
helm package ./tmp/$MY_UUID/


# helm install --dry-run \
# --set docker_hub_secret=$DOCKER_HUB_SECRET \
# --debug $APPLICATION ./tmp/$MY_UUID/ \
# --values ./tmp/$MY_UUID/common-values.yaml \
# --values ./tmp/$MY_UUID/$REGION-values.yaml \
# --values ./tmp/$MY_UUID/$VARIANTS-values.yaml \
# --values ./tmp/$MY_UUID/$ENVIRONMENT-$APPLICATION-values.yaml

helm repo index --url https://tatroc.github.io/helm-package-example/ .
cat index.yaml

git checkout $BRANCH_NAME
git --no-pager branch
git add .
git commit -m 'new helm package'
git push



#!/bin/bash
./package.sh --environment prd \
--cluster cluster2 \
--region us-east-1 \
--variants prd \
--cluster-type common \
--application argocd

#!/bin/bash

x=($(ls ./tmp/$MY_UUID/*-values.yaml))

for I in "${x[@]}"
do
    VALUES=${VALUES:+$VALUES }"--values $I"
done


mkdir -p ./tmp/$MY_UUID/output

cp charts/$CLUSTER_TYPE/$APPLICATION/.snyk ./tmp/$MY_UUID/output

command="helm lint ./tmp/$MY_UUID/ $VALUES"
echo "building helm command: $command"

echo "create templates from helm command"
eval $command
#!/bin/bash

x=($(ls ./tmp/$MY_UUID/*-values.yaml))

for I in "${x[@]}"
do
    VALUES=${VALUES:+$VALUES }"--values $I"
done


mkdir -p ./tmp/$MY_UUID/output

cp charts/$CLUSTER_TYPE/$APPLICATION/.snyk ./tmp/$MY_UUID/output

command="helm template ./tmp/$MY_UUID/ --output-dir ./tmp/$MY_UUID/output $VALUES"
echo "building helm template command: $command"

echo "create templates from helm command"
eval $command

#helm template ./tmp/$MY_UUID/ --output-dir ./tmp/$MY_UUID/output

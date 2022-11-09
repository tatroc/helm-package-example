#!/bin/bash

x=($(ls ./tmp/$MY_UUID/*-values.yaml))

for I in "${x[@]}"
do
    VALUES=${VALUES:+$VALUES }"--values $I"
done

command="helm template ./tmp/$MY_UUID/ --output-dir ./tmp/$MY_UUID/output $VALUES"
echo "building helm command: $command"

echo "executing helm command"
eval $command

helm template ./tmp/$MY_UUID/ --output-dir ./tmp/$MY_UUID/output

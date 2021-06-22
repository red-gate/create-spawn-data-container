#!/bin/bash

set -e

dataImage=$1
lifetime=$2

shift 2

if [[ -z "$SPAWNCTL_ACCESS_TOKEN" ]]; then
    echo "SPAWNCTL_ACCESS_TOKEN is not set"
    exit 1
fi

newDcName=$(spawnctl create data-container --image "$dataImage" --lifetime $lifetime $@ -q)
jsonOutput=$(spawnctl get data-container $newDcName -o json)
host=$(echo $jsonOutput | jq -r '.host')
port=$(echo $jsonOutput | jq -r '.port')
username=$(echo $jsonOutput | jq -r '.user')
password=$(echo $jsonOutput | jq -r '.password')

echo ::set-output name=dataContainerName::"$newDcName"
echo ::set-output name=dataContainerHost::"$host"
echo ::add-mask::$port
echo ::set-output name=dataContainerPort::"$port"
echo ::add-mask::$username
echo ::set-output name=dataContainerUsername::"$username"
echo ::add-mask::$password
echo ::set-output name=dataContainerPassword::"$password"
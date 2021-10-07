#!/bin/bash

set -e

dataImage=$1
lifetime=$2
useMasking=$3

shift 3

if [[ -z "$SPAWNCTL_ACCESS_TOKEN" ]]; then
    echo "SPAWNCTL_ACCESS_TOKEN is not set"
    exit 1
fi

if [ $useMasking != "true" ] && [ "$useMasking" != "false" ]; then
  echo "masking must be set to either 'true' or 'false'. Received: $useMasking"
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

if [ "$useMasking" = "true" ]; then
  echo ::add-mask::$port
fi
echo ::set-output name=dataContainerPort::"$port"

if [ "$useMasking" = "true" ]; then
  echo ::add-mask::$username
fi
echo ::set-output name=dataContainerUsername::"$username"

if [ "$useMasking" = "true" ]; then
  echo ::add-mask::$password
fi
echo ::set-output name=dataContainerPassword::"$password"
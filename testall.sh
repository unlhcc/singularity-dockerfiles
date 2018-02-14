#!/bin/bash

set -euo pipefail

imageList=`ls -1d */ | cut -f1 -d '/'`
for image in $imageList
do
    rm -rf ~/.singularity/docker/*
    source ${image}/test.sh
    testCommand="singularity exec docker://$REGISTRY_HOSTNAME:$REGISTRY_PORT/$HCC_REPO_NAMESPACE/${image} ${imageCommand}"
    echo "Running test command '$testCommand'"
    eval $testCommand

done

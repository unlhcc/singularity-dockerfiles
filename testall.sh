#!/bin/bash

set -euo pipefail

imageList=`ls -1d */ | cut -f1 -d '/'`
for image in $imageList
do
    source ${image}/test.sh
    testCommand="singularity exec -r $REGISTRY_HOSTNAME:$REGISTRY_PORT docker:///${image} ${imageCommand}"
    echo "Running test command '$testCommand'"
    eval $testCommand

done

#!/bin/bash

set -euo pipefail

printf '%s\n' "Running 'git fetch origin master' to get master branch..."
git fetch origin master

printf '%s\n' "Finding changed images according to git..."
# Get a unique list of top-level directories for any changed files
dirList=`git diff  --name-only master HEAD | xargs -d ' ' dirname | sort | uniq`

# Loop through and only include images (directories) that have a file that
# matches the 'Dockerf*' glob.
declare -a imageList
imageList=()
for aDir in $dirList;
do
    if [ -e ${aDir}/Dockerf* ]
    then
      imageList+=("$aDir")
    fi
done

# Only test if there's at least one changed image.
if [ -z "${imageList+set}" ]
then
    printf '%s\n' "No images changed according to git, exiting."
    exit 0
elif [ ${#imageList[@]} -ge 1 ]
then
    printf '%s\n' "Images changed according to git:"
    printf '\t%s\n' "${imageList[@]}"
    printf '%s\n' "Running test on changed image(s)..."
    for image in ${imageList[@]}
    do
        source ${image}/test.sh
        testCommand="singularity exec docker://$REGISTRY_HOSTNAME:$REGISTRY_PORT/$HCC_REPO_NAMESPACE/${image} ${imageCommand}"
        echo "Running test command '$testCommand'"
        eval $testCommand
    done
else
    printf '%s\n' "The image list to test is an empty string."
    printf '%s\n' "This should never happen, bailing out!"
    exit 1
fi

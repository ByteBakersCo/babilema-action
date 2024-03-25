#!/bin/bash

# Making sure that the script will exit if a command fails
set -e

IS_PULL_REQUEST=$(echo "$GITHUB_CONTEXT" | jq -e '.event.pull_request' > /dev/null && echo "true" || echo "false")

if [  "$IS_PULL_REQUEST" = "true" ]; then
    BRANCH=$(echo "$GITHUB_CONTEXT" | jq -r '.event.pull_request.head.ref')
else
    BRANCH=$(echo "$GITHUB_CONTEXT" | jq -r '.ref' | jq -R -r 'split("/") | last')
fi

echo $BRANCH

# git clone https://github.com/ByteBakersCo/babilema.git tmp
# cd tmp
# ./build.sh

# mv babilema "$GITHUB_WORKSPACE/"
# cd "$GITHUB_WORKSPACE"
# rm -rf "$GITHUB_WORKSPACE/tmp"

# $GITHUB_WORKSPACE/babilema --config "$CONFIG"
# rm "$GITHUB_WORKSPACE/babilema"

# git config --global user.name "Babilema GH Action"
# git config --global user.email "action@github.com"
# git config --global --add safe.directory "$GITHUB_WORKSPACE"

# git checkout -b "$BRANCH"

# git add -A
# git commit -m "$COMMIT_MESSAGE"
# git push https://$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git

echo "Successfully pushed generated files to $GITHUB_REPOSITORY"

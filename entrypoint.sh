#!/bin/bash

# Making sure that the script will exit if a command fails
set -e

if [ -z "$GITHUB_CONTEXT" ]; then
    echo "GITHUB_CONTEXT is not set."
    exit 1
fi

if [ -z "$GITHUB_TOKEN" ]; then
    echo "GITHUB_TOKEN is not set."
    exit 1
fi

BRANCH=$(echo "$GITHUB_CONTEXT" | jq -r '.ref' | jq -R -r 'split("/") | last')
EVENT_NAME=$(echo "$GITHUB_CONTEXT" | jq -r '.event_name')

if [ "$EVENT_NAME" = "pull_request" ]; then
    BRANCH=$(echo "$GITHUB_CONTEXT" | jq -r '.head_ref')
fi

if [ -z "$BRANCH" ]; then
    echo "Could not determine the branch."
    exit 1
fi

git clone https://github.com/ByteBakersCo/babilema.git tmp
cd tmp
./build.sh

mv babilema "$GITHUB_WORKSPACE/"
cd "$GITHUB_WORKSPACE"
rm -rf "$GITHUB_WORKSPACE/tmp"

$GITHUB_WORKSPACE/babilema --config "$CONFIG"
rm "$GITHUB_WORKSPACE/babilema"

git config --global user.name "Babilema GH Action"
git config --global user.email "action@github.com"
git config --global --add safe.directory "$GITHUB_WORKSPACE"

git checkout "$BRANCH"

git add -A
git commit -m "$COMMIT_MESSAGE"
git push https://$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git

echo "Successfully pushed generated files to $GITHUB_REPOSITORY on branch $BRANCH."

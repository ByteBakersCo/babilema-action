#!/bin/bash

# Making sure that the script will exit if a command fails
set -e

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

echo "Checking out $GITHUB_REF_NAME"
git checkout "$GITHUB_REF_NAME" "remote/$GITHUB_REF_NAME"

git add -A
git commit -m "$COMMIT_MESSAGE"
git push https://$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git

echo "Successfully pushed generated files to $GITHUB_REPOSITORY"

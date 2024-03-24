#!/bin/bash

# Making sure that the script will exit if a command fails
set -e

git config --global user.name "Babilema GH Action"
git config --global user.email "action@github.com"

./babilema --config "$INPUT_CONFIG"

git add -A
git commit -m "$INPUT_COMMIT_MESSAGE"
git push https://$GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY.git

echo "Successfully pushed generated files to $GITHUB_REPOSITORY"

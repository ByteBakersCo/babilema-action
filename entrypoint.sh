#!/bin/bash

# Making sure that the script will exit if a command fails
set -e

if [ -z "$GITHUB_TOKEN" ]; then
    echo "GITHUB_TOKEN is not set."
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

echo "Exiting action..."

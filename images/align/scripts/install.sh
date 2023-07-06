#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$ALIGN_REPO_COMMIT" | cut -c 1-7)

mkdir -p "$TOOLS"
#cd /foss/tools
git clone "$ALIGN_REPO_URL" "${TOOLS}/$ALIGN_NAME/$REPO_COMMIT_SHORT"
cd "${TOOLS}/$ALIGN_NAME/$REPO_COMMIT_SHORT" || exit 1
git checkout "$ALIGN_REPO_COMMIT"

#python3 setup.py install
pip3 install . --prefix="${TOOLS}/$ALIGN_NAME/$REPO_COMMIT_SHORT" --no-cache-dir


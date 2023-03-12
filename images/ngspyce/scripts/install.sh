#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$NGSPYCE_REPO_COMMIT" | cut -c 1-7)

mkdir -p /foss/tools
git clone "$NGSPYCE_REPO_URL" "/foss/tools/$NGSPYCE_NAME/$REPO_COMMIT_SHORT"
cd "/foss/tools/$NGSPYCE_NAME/$REPO_COMMIT_SHORT" || exit 1
git checkout "$NGSPYCE_REPO_COMMIT"

#python3 setup.py install
pip3 install . --prefix="/foss/tools/$NGSPYCE_NAME/$REPO_COMMIT_SHORT" --no-cache-dir

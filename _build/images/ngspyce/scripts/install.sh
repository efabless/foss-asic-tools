#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$NGSPYCE_REPO_COMMIT" | cut -c 1-7)

mkdir -p "$TOOLS"
git clone --filter=blob:none "$NGSPYCE_REPO_URL" "${TOOLS}/$NGSPYCE_NAME/$REPO_COMMIT_SHORT"
cd "${TOOLS}/$NGSPYCE_NAME/$REPO_COMMIT_SHORT" || exit 1
git checkout "$NGSPYCE_REPO_COMMIT"

#python3 setup.py install
pip3 install . --prefix="${TOOLS}/$NGSPYCE_NAME/$REPO_COMMIT_SHORT" --no-cache-dir

#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$ALIGN_REPO_COMMIT" | cut -c 1-7)

mkdir -p /foss/tools
cd /foss/tools
git clone "${ALIGN_REPO_URL}" "${ALIGN_NAME}"
cd "${ALIGN_NAME}"
git checkout "${ALIGN_REPO_COMMIT}"

#create a python virtualenv
python3 -m venv general
source general/bin/activate
python3 -m pip install pip --upgrade

#install align as a user
pip install -v .
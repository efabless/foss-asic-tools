#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$ALIGN_REPO_COMMIT" | cut -c 1-7)

mkdir -p /foss/tools
#cd /foss/tools
git clone "$ALIGN_REPO_URL" "/foss/tools/$ALIGN_NAME/$REPO_COMMIT_SHORT"
cd "/foss/tools/$ALIGN_NAME/$REPO_COMMIT_SHORT" || exit 1
git checkout "$ALIGN_REPO_COMMIT"

#create a python virtualenv
#python3 -m venv general --without-pip --system-site-packages
#source general/bin/activate
#python3 -m pip install pip --upgrade
pip3 install . --prefix="/foss/tools/$ALIGN_NAME/$REPO_COMMIT_SHORT" --no-cache-dir

#install align as a user
#pip install -v .

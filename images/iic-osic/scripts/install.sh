#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

mkdir -p /foss/tools
cd /foss/tools
git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

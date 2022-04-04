#!/bin/bash

source scl_source enable devtoolset-8

mkdir -p /foss/tools
cd /foss/tools
git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

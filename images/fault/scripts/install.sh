#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $REPO_COMMIT | cut -c 1-7)

mkdir -p /foss/tools/${NAME}/${REPO_COMMIT_SHORT}
git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}
git submodule update --init --recursive

INSTALL_DIR=/foss/tools/${NAME}/${REPO_COMMIT_SHORT} swift ./install.swift


#!/bin/bash

source scl_source enable gcc-toolset-9

mkdir -p /foss/tools/${NAME}/${REPO_COMMIT}

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}
git submodule update --init --recursive

INSTALL_DIR=/foss/tools/${NAME}/${REPO_COMMIT} swift ./install.swift


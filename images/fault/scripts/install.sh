#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $FAULT_REPO_COMMIT | cut -c 1-7)

mkdir -p /foss/tools/${FAULT_NAME}/${REPO_COMMIT_SHORT}
git clone ${FAULT_REPO_URL} ${FAULT_NAME}
cd ${FAULT_NAME}
git checkout ${FAULT_REPO_COMMIT}
git submodule update --init --recursive

INSTALL_DIR=/foss/tools/${FAULT_NAME}/${REPO_COMMIT_SHORT} swift ./install.swift

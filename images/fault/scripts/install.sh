#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$FAULT_REPO_COMMIT" | cut -c 1-7)

mkdir -p "${TOOLS}/${FAULT_NAME}/${REPO_COMMIT_SHORT}"
git clone --filter=blob:none "${FAULT_REPO_URL}" "${FAULT_NAME}"
cd "${FAULT_NAME}"
git checkout "${FAULT_REPO_COMMIT}"
git submodule update --init --recursive

export PATH=/opt/swift/usr/bin:$PATH
INSTALL_DIR=${TOOLS}/${FAULT_NAME}/${REPO_COMMIT_SHORT} swift ./install.swift

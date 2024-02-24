#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$FAULT_REPO_COMMIT" | cut -c 1-7)

if [ "$(arch)" == "x86_64" ]; then
    #FIXME compile fail on arm64 needs fixing (only on macOS)
    mkdir -p "${TOOLS}/${FAULT_NAME}/${REPO_COMMIT_SHORT}"
    git clone --filter=blob:none "${FAULT_REPO_URL}" "${FAULT_NAME}"
    cd "${FAULT_NAME}"
    git checkout "${FAULT_REPO_COMMIT}"
    git submodule update --init --recursive
    echo "[INFO] Compiling Fault using Swift."
    export PATH=/opt/swift/usr/bin:$PATH
    INSTALL_DIR=${TOOLS}/${FAULT_NAME}/${REPO_COMMIT_SHORT} swift ./install.swift
else
    mkdir -p "${TOOLS}/${FAULT_NAME}/${REPO_COMMIT_SHORT}"
    echo "This CPU architecture is not working currently!" > "${TOOLS}/${FAULT_NAME}/${REPO_COMMIT_SHORT}/README.txt"
fi

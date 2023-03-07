#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$ALIGN_PDK_SKY130_REPO_COMMIT" | cut -c 1-7)

mkdir -p /foss/tools
cd /foss/tools
git clone "${ALIGN_PDK_SKY130_REPO_URL}" "${ALIGN_PDK_SKY130_NAME}"
cd "${ALIGN_PDK_SKY130_NAME}"
git checkout "${ALIGN_PDK_SKY130_REPO_COMMIT}"

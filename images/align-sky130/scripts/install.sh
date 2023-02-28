#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$ALIGN_SKY130_REPO_COMMIT" | cut -c 1-7)

git clone "${ALIGN_SKY130_REPO_URL}" "${ALIGN_SKY130_NAME}"
cd "${ALIGN_SKY130_NAME}"
git checkout "${ALIGN_SKY130_NAME}"

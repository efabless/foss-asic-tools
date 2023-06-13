#!/bin/bash

set -e

mkdir -p "$TOOLS"
cd "$TOOLS"
git clone "${OSIC_MULTITOOL_REPO_URL}" "${OSIC_MULTITOOL_NAME}"
cd "${OSIC_MULTITOOL_NAME}"
git checkout "${OSIC_MULTITOOL_REPO_COMMIT}"

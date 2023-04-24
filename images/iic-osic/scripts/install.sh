#!/bin/bash

set -e

mkdir -p "$TOOLS"
cd "$TOOLS"
git clone "${IIC_OSIC_REPO_URL}" "${IIC_OSIC_NAME}"
cd "${IIC_OSIC_NAME}"
git checkout "${IIC_OSIC_REPO_COMMIT}"

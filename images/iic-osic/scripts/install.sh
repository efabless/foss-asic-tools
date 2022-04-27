#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

mkdir -p /foss/tools
cd /foss/tools
git clone ${IIC_OSIC_REPO_URL} ${IIC_OSIC_NAME}
cd ${IIC_OSIC_NAME}
git checkout ${IIC_OSIC_REPO_COMMIT}

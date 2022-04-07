#!/bin/bash

source scl_source enable gcc-toolset-9

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

make PREFIX=/foss/tools/${NAME}/${REPO_COMMIT} config-gcc
make PREFIX=/foss/tools/${NAME}/${REPO_COMMIT} -j$(nproc)
make PREFIX=/foss/tools/${NAME}/${REPO_COMMIT} install

#!/bin/bash

git clone ${REPO_URL} ${NAME}
cd ${NAME}
git checkout ${REPO_COMMIT}

chmod +x autoconf.sh
PATH=/opt/gperf/bin:$PATH ./autoconf.sh
./configure --prefix=/foss/tools/${NAME}/${REPO_COMMIT}
make -j$(nproc)
make install

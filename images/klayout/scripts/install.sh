#!/bin/bash


wget https://www.klayout.org/downloads/CentOS_7/klayout-0.27.10-0.x86_64.rpm 
yum  --installroot=/foss/tools/klayout --releasever=/ install -y klayout-0.27.10-0.x86_64.rpm




#\rm -f /usr/bin/gmake && ln -s /usr/bin/make /usr/bin/gmake

#git clone ${REPO_URL} ${NAME}
#cd ${NAME}
#git checkout ${REPO_COMMIT}

#./configure --prefix=/foss/tools/${NAME}/${REPO_COMMIT}

#mkdir -p /foss/tools/klayout/1081c17

#git clone https://github.com/KLayout/klayout && cd klayout/ && git checkout 1081c17 && ./build.sh -j$(nproc) -prefix /foss/tools/klayout/1081c17
 

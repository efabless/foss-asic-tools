#!/bin/bash

set -e
source scl_source enable gcc-toolset-9

REPO_COMMIT_SHORT=$(echo $REPO_COMMIT | cut -c 1-7)

#install_openlane_tools() {
#	cd docker
#	make export-all
#	mkdir -p /foss/tools/${NAME}_tools/${REPO_COMMIT}
#	cp -r build/* /foss/tools/${NAME}_tools/${REPO_COMMIT}
#}
#install_openlane_tools
#python3 ./env.py local-install
#cd /foss/tools

mkdir -p /foss/tools/
git clone ${REPO_URL} /foss/tools/${NAME}/${REPO_COMMIT_SHORT}
cd /foss/tools/${NAME}/${REPO_COMMIT_SHORT}
git checkout ${REPO_COMMIT}

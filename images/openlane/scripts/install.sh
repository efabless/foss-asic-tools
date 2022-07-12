#!/bin/bash

set -e
source scl_source enable gcc-toolset-11

#install_openlane_tools() {
#	cd docker
#	make export-all
#	mkdir -p /foss/tools/${NAME}_tools/${REPO_COMMIT}
#	cp -r build/* /foss/tools/${NAME}_tools/${REPO_COMMIT}
#}
#install_openlane_tools
#python3 ./env.py local-install
#cd /foss/tools

REPO_COMMIT_SHORT=$(echo $OPENLANE_REPO_COMMIT | cut -c 1-7)

mkdir -p /foss/tools/
git clone ${OPENLANE_REPO_URL} /foss/tools/${OPENLANE_NAME}/${REPO_COMMIT_SHORT}
cd /foss/tools/${OPENLANE_NAME}/${REPO_COMMIT_SHORT}
git checkout ${OPENLANE_REPO_COMMIT}

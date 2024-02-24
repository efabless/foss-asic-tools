#!/bin/bash

set -e

#install_openlane_tools() {
#	cd docker
#	make export-all
#	mkdir -p ${TOOLS}/${NAME}_tools/${REPO_COMMIT}
#	cp -r build/* ${TOOLS}/${NAME}_tools/${REPO_COMMIT}
#}
#install_openlane_tools
#python3 ./env.py local-install
#cd $TOOLS

REPO_COMMIT_SHORT=$(echo "$OPENLANE_REPO_COMMIT" | cut -c 1-10)

mkdir -p "$TOOLS"
git clone --filter=blob:none "${OPENLANE_REPO_URL}" "${TOOLS}/${OPENLANE_NAME}/${REPO_COMMIT_SHORT}"
cd "${TOOLS}/${OPENLANE_NAME}/${REPO_COMMIT_SHORT}"
git checkout "${OPENLANE_REPO_COMMIT}"

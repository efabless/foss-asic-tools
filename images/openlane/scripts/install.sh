#!/bin/bash

source scl_source enable devtoolset-8


install_openlane_tools() {
	cd docker_build
	make export-all
	mkdir -p /foss/tools/${NAME}_tools/${REPO_COMMIT}
	cp -r build/* /foss/tools/${NAME}_tools/${REPO_COMMIT}
}

mkdir -p /foss/tools/
git clone ${REPO_URL} /foss/tools/${NAME}/${REPO_COMMIT}
cd /foss/tools/${NAME}/${REPO_COMMIT}

git checkout ${REPO_COMMIT}

install_openlane_tools


#!/bin/bash

source scl_source enable devtoolset-8


install_openlane_tools() {
	cd docker
	make export-all
	mkdir -p /foss/tools/${NAME}_tools/${REPO_COMMIT}
	cp -r build/* /foss/tools/${NAME}_tools/${REPO_COMMIT}
}

mkdir -p /foss/tools/
git clone ${REPO_URL} /foss/tools/${NAME}/${REPO_COMMIT}
cd /foss/tools/${NAME}/${REPO_COMMIT}

git checkout ${REPO_COMMIT}

install_openlane_tools


   1  apt update
    2  apt upgrade
    3  apt install git sudo 
    4  mkdir -r /foss/tools
    5  mkdir -p /foss/tools
    6  cd /foss/tools/
    7  git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git
    8  cd OpenROAD/
    9  ll
   10  ./etc/DependencyInstaller.sh -dev
   11  cat README.md 
   12  history
   13  ls /foss/tools/
   14  ls /foss/tools/bin/
   15  h
   16  history


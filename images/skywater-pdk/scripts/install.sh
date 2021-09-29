#!/bin/bash

source scl_source enable devtoolset-8

mkdir -p /foss/pdks
git clone ${REPO_URL} /foss/pdks/${NAME}/
cd /foss/pdks/${NAME}/ && \
git checkout main && git submodule init && git pull --no-recurse-submodules && \
git checkout -qf ${REPO_COMMIT} && \
git submodule update --init libraries/sky130_fd_sc_hd/latest && \
git submodule update --init libraries/sky130_fd_io/latest && \
git submodule update --init libraries/sky130_fd_sc_hvl/latest && \
git submodule update --init libraries/sky130_fd_pr/latest && \
make timing


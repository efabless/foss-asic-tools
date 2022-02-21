#!/bin/bash

source scl_source enable devtoolset-8

mkdir -p /foss/pdks 
git clone ${REPO_URL} /foss/pdks/${NAME}/ 
cd /foss/pdks/${NAME}/ && \
git checkout main && \
git checkout -qf ${REPO_COMMIT} && \
git submodule update --init libraries/sky130_fd_sc_hd/latest && \
git submodule update --init libraries/sky130_fd_io/latest && \
git submodule update --init libraries/sky130_fd_sc_hvl/latest && \
git submodule update --init libraries/sky130_fd_pr/latest && \
git submodule update --init libraries/sky130_fd_pr_reram/latest && \
git submodule update --init libraries/sky130_fd_sc_lp/latest  && \
git submodule update --init libraries/sky130_fd_sc_hs/latest  && \
git submodule update --init libraries/sky130_fd_sc_ms/latest  && \
git submodule update --init libraries/sky130_fd_sc_ls/latest  && \
git submodule update --init libraries/sky130_fd_sc_hdll/latest && \
git submodule update

python3 -m pip install -e scripts/python-skywater-pdk
mv /foss/pdks/make_timing.py .
mv /foss/pdks/corners.yml .
python3 ./make_timing.py

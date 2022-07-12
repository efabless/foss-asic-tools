#!/bin/bash

set -e
source scl_source enable gcc-toolset-11

REPO_COMMIT_SHORT=$(echo $XYCE_XDM_REPO_COMMIT | cut -c 1-7)

git clone ${XYCE_XDM_REPO_URL} ${XYCE_XDM_NAME}
cd ${XYCE_XDM_NAME}
git checkout ${XYCE_XDM_REPO_COMMIT}

#FIXME path build errors
sed -i 's/isnan/std::isnan/g' src/c_boost/expr/ast_common.hpp
sed -i 's/isnan/std::isnan/g' src/c_boost/expr/hspice_expr_parser_interface.cpp
sed -i 's/isnan/std::isnan/g' src/c_boost/expr/spectre_expr_parser_interface.cpp

mkdir build && cd build
PREFIX=/foss/tools/${XYCE_XDM_NAME}/${REPO_COMMIT_SHORT}
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX ..
make -j$(nproc)
make install

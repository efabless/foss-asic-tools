#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$RISCV_GNU_TOOLCHAIN_RV32I_REPO_COMMIT" | cut -c 1-7)

git clone "${RISCV_GNU_TOOLCHAIN_RV32I_REPO_URL}" "${RISCV_GNU_TOOLCHAIN_RV32I_NAME}"
cd "${RISCV_GNU_TOOLCHAIN_RV32I_NAME}"
git checkout "${RISCV_GNU_TOOLCHAIN_RV32I_REPO_COMMIT}"
git submodule update --init --recursive
mkdir build && cd build
../configure --with-arch=rv32ia --prefix="/foss/tools/${RISCV_GNU_TOOLCHAIN_RV32I_NAME}/${REPO_COMMIT_SHORT}"
make linux -j"$(nproc)"

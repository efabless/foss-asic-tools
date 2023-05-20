#!/bin/bash

set -e
mkdir -p "${TOOLS}/${RFTK_NAME}"

# FastHenry2 for inductance extractions
# -------------------------------------
cd /tmp
git clone "${RFTK_FASTHENRY_REPO_URL}" "${RFTK_NAME}_fh"
cd "${RFTK_NAME}_fh"
git checkout "${RFTK_FASTHENRY_REPO_COMMIT}"
# patch FastHenry Makefiles (fix thanks to Ali Olyanasab)
sed -i '/^CFLAGS/ s/$/ -fcommon -w/' src/fasthenry/Makefile
sed -i '/^CFLAGS/ s/$/ -fcommon -w/' src/fasthenry/sparse/Makefile
make -j"$(nproc)" all
cp -R bin "${TOOLS}/${RFTK_NAME}"
cp -R doc "${TOOLS}/${RFTK_NAME}"
cp -R examples "${TOOLS}/${RFTK_NAME}"

# FasterCap for capacitance extractions
# -------------------------------------
cd /tmp
git clone "${RFTK_FASTERCAP_REPO_URL}" "${RFTK_NAME}_fc"
# get additional libs (LinAlgebra and Geometry)
# FIXME check if lib versions fit to FasterCap version (last done 2023-05-20)
git clone https://github.com/ediloren/LinAlgebra.git
cd LinAlgebra
git checkout 627132d70bfd7eadd727f930286938a5a01d9914
cd ..
git clone https://github.com/ediloren/Geometry.git
cd Geometry
git checkout de03ffebfd5013b96102bd60f71c8fe8b73870e2
cd ..
# now build FasterCap
cd "${RFTK_NAME}_fc"
# patch FasterCap cmake (fix thanks to Ali Olyanasab) 
sed -i '3 i add_definitions(-w)' CMakeLists.txt
mkdir build && cd build
#cmake -G"CodeBlocks - Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
cmake -G"Unix Makefiles"  -DCMAKE_BUILD_TYPE=Release -DFASTFIELDSOLVERS_HEADLESS=ON ..
make -j"$(nproc)" all
cp FasterCap "${TOOLS}/${RFTK_NAME}/bin"

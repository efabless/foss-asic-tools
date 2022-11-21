#!/bin/sh

export PATH="$PATH:/usr/lib64/openmpi/bin"
REPO_COMMIT_SHORT=$(echo "$XYCE_REPO_COMMIT" | cut -c 1-7)

../configure \
	CXXFLAGS="-O3" \
	ARCHDIR="/$XYCE_NAME/XyceLibs/Parallel" \
	CPPFLAGS="-I/usr/include/suitesparse" \
	--enable-mpi \
	CXX=/usr/lib64/openmpi/bin/mpicxx \
	CC=/usr/lib64/openmpi/bin/mpicc \
	F77=/usr/lib64/openmpi/bin/mpif77 \
	--enable-stokhos \
	--enable-amesos2 \
	--prefix="/foss/tools/${XYCE_NAME}/Parallel/${REPO_COMMIT_SHORT}"

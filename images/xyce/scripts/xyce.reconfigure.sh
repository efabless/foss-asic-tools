#!/bin/sh

export PATH="$PATH:/usr/lib64/openmpi/bin"
REPO_COMMIT_SHORT=$(echo "$XYCE_REPO_COMMIT" | cut -c 1-7)

../configure \
	ARCHDIR="/$XYCE_NAME/XyceLibs/Parallel" \
	CPPFLAGS="-I/usr/include/suitesparse" \
	--enable-mpi \
	CXX=mpicxx \
	CC=mpicc \
	F77=mpif77 \
	--enable-stokhos \
	--enable-amesos2 \
	--verbose \
	--prefix="/foss/tools/${XYCE_NAME}/Parallel/${REPO_COMMIT_SHORT}"

#x	CXXFLAGS="-O3" \

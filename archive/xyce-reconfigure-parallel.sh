#!/bin/bash

../Xyce/configure \
CXXFLAGS="-O3 -std=c++11" \
ARCHDIR=$XYCE_OUTDIR \
CPPFLAGS="-I/usr/include/suitesparse" \
--enable-mpi \
CXX=mpiCC \
CC=mpicc \
F77=mpif77


export PATH=$PATH:/usr/lib64/openmpi/bin
../configure \
CXXFLAGS="-O3 -std=c++11" \
ARCHDIR="/xyce/XyceLibs/Parallel" \
CPPFLAGS="-I/usr/include/suitesparse" \
--enable-shared \
--enable-Xyce-shareable \
--enable-mpi \
CXX=/usr/lib64/openmpi/bin/mpicxx \
CC=/usr/lib64/openmpi/bin/mpicc \
F77=/usr/lib64/openmpi/bin/mpif77 \
--prefix=/foss/tools/${NAME}/Parallel/${REPO_COMMIT} \
--enable-fft  --enable-intel_fft --enable-fftw   --enable-athena --enable-adms_sensitivities   --enable-hdf5

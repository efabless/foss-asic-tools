
# should old installations be deleted?
REPLACE 		= 0

# what type of Xyce should be installed?
XYCE_SERIAL 	= 1
XYCE_PARALLEL 	= 0

xschem:
ifeq ($(REPLACE),1)
	rm -rf /tools/xschem
endif
	sudo apt install -y libx11-dev libxrender1 libxrender-dev libxcb1 libxaw7-dev \
						libx11-xcb-dev libcairo2 libcairo2-dev tcl8.6 tcl8.6-dev \
						tk8.6 tk8.6-dev flex bison libxpm4 libxpm-dev gawk adms \
						libreadline6-dev
	cd /tools; \
	git clone git@github.com:StefanSchippers/xschem.git; \
	cd xschem; \
	./configure; \
	make; \
	sudo make install

xschem_sky130:
ifeq ($(REPLACE),1)
	rm -rf /tools/xschem_library
endif
	cd /tools; \
	mkdir -p xschem_library; \
	cd xschem_library; \
	git clone git@github.com:StefanSchippers/xschem_sky130.git; \
	cd xschem_sky130; \

magic:
ifeq ($(REPLACE),1)
	rm -rf /tools/magic
endif
	cd /tools; \
	git clone git://opencircuitdesign.com/magic; \
	cd magic; \
	./configure; \
	make; \
	sudo make install

netgen:
ifeq ($(REPLACE),1)
	rm -rf /tools/netgen
endif
	cd /tools; \
	git clone git://opencircuitdesign.com/netgen; \
	cd netgen; \
	./configure; \
	make; \
	sudo make install


open_pdks:
ifeq ($(REPLACE),1)
	rm -rf /pdk/open_pdks
endif
	sudo mkdir -p /pdk; \
	cd /pdk; \
	git clone git://opencircuitdesign.com/open_pdks; \
	cd open_pdks; \
	./configure --enable-sky130-pdk; \
	make; \
	sudo make install
	cp -f /usr/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc ~/.magicrc
	echo "export SKY130A=/usr/share/pdk/sky130A" >> ~/.bashrc

ngspice:
ifeq ($(REPLACE),1)
	rm -rf /tools/ngspice
endif
	cd /tools; \
	git clone git://git.code.sf.net/p/ngspice/ngspice; \
	cd ngspice; \
	git checkout pre-master; \
	./autogen.sh --adms; \
	mkdir release; \
	cd release; \
	../configure --with-x --enable-xspice --disable-debug --enable-cider --with-readline=yes --enable-openmp; \
	make; \
	sudo make install
	echo "set ngbehavior=hsa" > ~/.spiceinit

klayout:
ifeq ($(REPLACE),1)
	rm -rf /tools/klayout
endif
	cd /tools; \
	git clone git@github.com:KLayout/klayout.git; \
	cd klayout; \
	git fetch --tags; \
	latestTag=$(git describe --tags `git rev-list --tags --max-count=1`); \
	git checkout $latestTag; \
	./build.sh

venv:
ifeq ($(REPLACE),1)
	rm -rf ~/.venvs/amsat_txrx_ic
endif
	( \
	sudo apt install -y python3-pip python3-venv python3-virtualenv python3-numpy rustc libprotobuf-dev protobuf-compiler; \
	mkdir -p ~/.venvs; \
	cd ~/.venvs; \
	python3 -m venv amsat_txrx_ic; \
	. ~/.venvs/amsat_txrx_ic/bin/activate; \
	python -m pip install wheel; \
	python -m pip install -r $(PWD)/requirements.txt; \
	)

xyce:
ifeq ($(REPLACE),1)
	rm -rf /tools/xyce
endif
	sudo apt install -y gcc g++ gfortran make cmake bison flex libfl-dev libfftw3-dev libsuitesparse-dev \
						libblas-dev liblapack-dev libtool autoconf automake libopenmpi-dev openmpi-bin; \
	cd /tools; \
	mkdir -p xyce; cd xyce; \
	git clone https://github.com/Xyce/Xyce.git xyce_source; \
	cd xyce_source; ./bootstrap; cd ..; \
	mkdir -p trilinos; cd trilinos; \
	wget https://github.com/trilinos/Trilinos/archive/refs/tags/trilinos-release-12-12-1.tar.gz; \
	tar -xvf trilinos-release-12-12-1.tar.gz; \
	mv Trilinos-trilinos-release-12-12-1 trilinos_source; \
	rm trilinos-release-12-12-1.tar.gz

ifeq ($(XYCE_SERIAL),1)
	cd /tools/xyce/trilinos; \
	mkdir -p serial_build; cd serial_build; \
	echo '#!/bin/sh' > reconfigure; \
	echo 'SRCDIR=/tools/xyce/trilinos/trilinos_source' >> reconfigure; \
	echo 'ARCHDIR=/tools/xyce/xyce_libs/serial' >> reconfigure; \
	echo 'FLAGS="-O3 -fPIC"' >> reconfigure; \
	echo 'cmake \' >> reconfigure; \
	echo '-G "Unix Makefiles" \' >> reconfigure; \
	echo '-DCMAKE_C_COMPILER=gcc \' >> reconfigure; \
	echo '-DCMAKE_CXX_COMPILER=g++ \' >> reconfigure; \
	echo '-DCMAKE_Fortran_COMPILER=gfortran \' >> reconfigure; \
	echo '-DCMAKE_CXX_FLAGS="$$FLAGS" \' >> reconfigure; \
	echo '-DCMAKE_C_FLAGS="$$FLAGS" \' >> reconfigure; \
	echo '-DCMAKE_Fortran_FLAGS="$$FLAGS" \' >> reconfigure; \
	echo '-DCMAKE_INSTALL_PREFIX=$$ARCHDIR \' >> reconfigure; \
	echo '-DCMAKE_MAKE_PROGRAM="make" \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_NOX=ON \' >> reconfigure; \
	echo '-DNOX_ENABLE_LOCA=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_EpetraExt=ON \' >> reconfigure; \
	echo '-DEpetraExt_BUILD_BTF=ON \' >> reconfigure; \
	echo '-DEpetraExt_BUILD_EXPERIMENTAL=ON \' >> reconfigure; \
	echo '-DEpetraExt_BUILD_GRAPH_REORDERINGS=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_TrilinosCouplings=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Ifpack=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Isorropia=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_AztecOO=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Belos=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Teuchos=ON \' >> reconfigure; \
	echo '-DTeuchos_ENABLE_COMPLEX=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Amesos=ON \' >> reconfigure; \
	echo '-DAmesos_ENABLE_KLU=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Sacado=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Kokkos=OFF \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_CXX11=ON \' >> reconfigure; \
	echo '-DTPL_ENABLE_AMD=ON \' >> reconfigure; \
	echo '-DAMD_LIBRARY_DIRS="/usr/lib" \' >> reconfigure; \
	echo '-DTPL_AMD_INCLUDE_DIRS="/usr/include/suitesparse" \' >> reconfigure; \
	echo '-DTPL_ENABLE_BLAS=ON \' >> reconfigure; \
	echo '-DTPL_ENABLE_LAPACK=ON \' >> reconfigure; \
	echo '$$SRCDIR' >> reconfigure; \
	chmod u+x reconfigure; \
	./reconfigure; \
	make; \
	make install

	cd /tools/xyce; \
	mkdir -p serial_build; cd serial_build; \
	echo '../xyce_source/configure \' > reconfigure; \
	echo 'CXXFLAGS="-O3 -std=c++11" \' >> reconfigure; \
	echo 'ARCHDIR="/tools/xyce/xyce_libs/serial" \' >> reconfigure; \
	echo '--enable-shared \' >> reconfigure; \
	echo '--enable-xyce-shareable \' >> reconfigure; \
	echo 'CPPFLAGS="-I/usr/include/suitesparse" \' >> reconfigure; \
	echo '--prefix=/tools/xyce/install/serial' >> reconfigure; \
	chmod u+x reconfigure; \
	./reconfigure; \
	make; \
	make install
endif
ifeq ($(XYCE_PARALLEL),1)
	cd /tools/xyce/trilinos; \
	mkdir -p parallel_build; cd parallel_build; \
	echo '#!/bin/sh' > reconfigure; \
	echo 'SRCDIR=/tools/xyce/trilinos/trilinos_source' >> reconfigure; \
	echo 'ARCHDIR=/tools/xyce/xyce_libs/parallel' >> reconfigure; \
	echo 'FLAGS="-O3 -fPIC"' >> reconfigure; \
	echo 'cmake \' >> reconfigure; \
	echo '-G "Unix Makefiles" \' >> reconfigure; \
	echo '-DCMAKE_C_COMPILER=mpicc \' >> reconfigure; \
	echo '-DCMAKE_CXX_COMPILER=mpic++ \' >> reconfigure; \
	echo '-DCMAKE_Fortran_COMPILER=mpif77 \' >> reconfigure; \
	echo '-DCMAKE_CXX_FLAGS="$$FLAGS" \' >> reconfigure; \
	echo '-DCMAKE_C_FLAGS="$$FLAGS" \' >> reconfigure; \
	echo '-DCMAKE_Fortran_FLAGS="$$FLAGS" \' >> reconfigure; \
	echo '-DCMAKE_INSTALL_PREFIX=$$ARCHDIR \' >> reconfigure; \
	echo '-DCMAKE_MAKE_PROGRAM="make" \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_NOX=ON \' >> reconfigure; \
	echo '-DNOX_ENABLE_LOCA=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_EpetraExt=ON \' >> reconfigure; \
	echo '-DEpetraExt_BUILD_BTF=ON \' >> reconfigure; \
	echo '-DEpetraExt_BUILD_EXPERIMENTAL=ON \' >> reconfigure; \
	echo '-DEpetraExt_BUILD_GRAPH_REORDERINGS=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_TrilinosCouplings=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Ifpack=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_ShyLU=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Isorropia=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_AztecOO=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Belos=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Teuchos=ON \' >> reconfigure; \
	echo '-DTeuchos_ENABLE_COMPLEX=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Amesos=ON \' >> reconfigure; \
	echo '-DAmesos_ENABLE_KLU=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Sacado=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Kokkos=OFF \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_Zoltan=ON \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \' >> reconfigure; \
	echo '-DTrilinos_ENABLE_CXX11=ON \' >> reconfigure; \
	echo '-DTPL_ENABLE_AMD=ON \' >> reconfigure; \
	echo '-DAMD_LIBRARY_DIRS="/usr/lib" \' >> reconfigure; \
	echo '-DTPL_AMD_INCLUDE_DIRS="/usr/include/suitesparse" \' >> reconfigure; \
	echo '-DTPL_ENABLE_BLAS=ON \' >> reconfigure; \
	echo '-DTPL_ENABLE_LAPACK=ON \' >> reconfigure; \
	echo '-DTPL_ENABLE_MPI=ON \' >> reconfigure; \
	echo '$$SRCDIR' >> reconfigure; \
	chmod u+x reconfigure; \
	./reconfigure; \
	make; \
	make install

	cd /tools/xyce; \
	mkdir -p parallel_build; cd parallel_build; \
	echo '../xyce_source/configure \' > reconfigure; \
	echo 'CXXFLAGS="-O3 -std=c++11" \' >> reconfigure; \
	echo 'ARCHDIR="/tools/xyce/xyce_libs/parallel" \' >> reconfigure; \
	echo 'CPPFLAGS="-I/usr/include/suitesparse" \' >> reconfigure; \
	echo '--enable-shared \' >> reconfigure; \
	echo '--enable-xyce-shareable \' >> reconfigure; \
	echo '--enable-mpi \' >> reconfigure; \
	echo 'CXX=mpicxx \' >> reconfigure; \
	echo 'CC=mpicc \' >> reconfigure; \
	echo 'F77=mpif77 \' >> reconfigure; \
	echo '--prefix=/tools/xyce/install/parallel' >> reconfigure; \
	chmod u+x reconfigure; \
	./reconfigure; \
	make; \
	make install
endif

all: xschem xschem_sky130 magic netgen open_pdks ngspice klayout venv xyce
	@echo "Done"

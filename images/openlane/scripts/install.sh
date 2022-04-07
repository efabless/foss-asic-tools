#!/bin/bash

source scl_source enable gcc-toolset-9

#install_openlane_tools() {
#	cd docker
#	make export-all
#	mkdir -p /foss/tools/${NAME}_tools/${REPO_COMMIT}
#	cp -r build/* /foss/tools/${NAME}_tools/${REPO_COMMIT}
#}

mkdir -p /foss/tools/
git clone ${REPO_URL} /foss/tools/${NAME}/${REPO_COMMIT}
cd /foss/tools/${NAME}/${REPO_COMMIT}
git checkout ${REPO_COMMIT}

#install_openlane_tools
#python3 ./env.py local-install
#cd /foss/tools

install_openroad () {
	cd /tmp
    	git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git
    	cd OpenROAD
    	git checkout 944855835623e651e7b9c7c50efcce1fb04b4fee
    
	mkdir -p build/
    	cd build
    	CFLAGS='-Wno-narrowing' cmake .. "-DCMAKE_INSTALL_PREFIX=/foss/tools/${NAME}/${REPO_COMMIT}"
    	make -j$(nproc)
}

install_cugr () {
	cd /tmp
	git clone https://github.com/ax3ghazy/cu-gr
	cd cu-gr
	git checkout 1632b4b450cbd3e5b6bdc9bf92c96cadde6a01b9

	xxd -i src/flute/POST9.dat > src/flute/POST9.c
    	xxd -i src/flute/POWV9.dat > src/flute/POWV9.c
    	
	mkdir -p build/
    	cd build
    	cmake ../src
    	make -j$(nproc)
    	cp iccad19gr /foss/tools/${NAME}/${REPO_COMMIT}/bin/cugr
}

install_drcu () {
	cd /tmp
	git clone https://github.com/cuhk-eda/dr-cu
	cd dr-cu
	git checkout 427b4a4f03bb98d8a78b1712fe9e52cfb83a8347

    	mkdir -p build/
    	cd build
    	cmake ../src
    	make -j$(nproc)
    	cp ispd19dr /foss/tools/${NAME}/${REPO_COMMIT}/bin/drcu
}

install_vlogtoverilog () {
	cd /tmp
	git clone https://github.com/RTimothyEdwards/qflow
	cd qflow
	git checkout a550469b63e910ede6e3022e2886bca96462c540

	./configure
    	cd src
    	make -j$(nproc) vlog2Verilog
    	cp vlog2Verilog /foss/tools/${NAME}/${REPO_COMMIT}/bin
}


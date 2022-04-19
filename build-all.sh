#!/bin/bash
# Harald Pretl, IIC, JKU, 2022
#
# Build script for IIC docker images
#
# Order(s) for building: 
#	first is `base`, then `magic`
#	`skywater-pdk` before `open_pdks`
#	`ghdl` and `yosys` must be built before `ghdl-yosys-plugin`
#	last is `foss-asic-tools`

if [ -z ${VIRTUAL_ENV+x} ]; then
	source venv/bin/activate
fi

python3 run.py build \
	base magic \
	covered \
	cugr \
	cvc-check \
	drcu \
	fault \
	gaw3-xschem \
	gtkwave \
	iic-osic \
	irsim \
	iverilog \
	klayout \
	netgen \
	ngscope \
	ngspice \
	openlane \
	openroad \
	opensta \
	padring \
	qflow \
	riscv-gnu-toolchain-rv32i \
	skywater-pdk open_pdks \
	verilator \
	xschem \
	xyce xyce-xdm \
	ghdl yosys ghdl-yosys-plugin \
	foss-asic-tools

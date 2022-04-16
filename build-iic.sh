# Harald Pretl, IIC, JKU
#
# Build script for IIC docker images
#
# Order for building: base first, then magic; skywater-pdk before open_pdks; last is foss-asic-tools

source venv/bin/activate
python3 run.py build \
	base magic \
	covered \
	cvc-check \
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
	xyce \
	ghdl yosys ghdl-yosys-plugin \
	foss-asic-tools

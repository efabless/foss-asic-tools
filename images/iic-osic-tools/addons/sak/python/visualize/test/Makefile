
schematics = RC2.sch

simulations = dc_dc_ascii.cir complicated_ascii.cir complicated_binary.cir \
	tran_binary.cir dc_dc_binary.cir dc_ascii.cir \
	tran_ascii.cir noise_ascii.cir \
	dc_binary.cir noise_binary.cir \
	ac_ascii.cir ac_binary.cir

netlists = RC2.net
rawfiles = dc_dc_ascii.raw complicated_ascii.raw complicated_binary.raw\
	tran_binary.raw dc_dc_binary.raw dc_ascii.raw \
	tran_ascii.raw noise_ascii.raw \
	dc_binary.raw noise_binary.raw \
	ac_ascii.raw ac_binary.raw

all: $(netlists) $(rawfiles) spiceread_test hdf5_test


clean:
	rm -rf *.raw
	rm -rf *.net
	rm -rf *.png
	rm -rf *.log
	rm -rf *~

spiceread_test: $(rawfiles)
	./test_binary.py
	./test_ascii.py
	../src/spice_read.py *raw >plot_listings.txt

hdf5_test: $(rawfiles)
	../../spice2hdf5.py  --pathprefix=/vectors -f vectors *raw
	../../spice2hdf5.py  --pathprefix=/tables -f table -o out.hdf5 *raw
	../../spice2hdf5.py  --pathprefix=/ac/myname ac_binary.raw
	../../spice2hdf5.py  -f vectors -o out.hdf5 dc_binary.raw

de_test:
	./DE_RCRC_test.py
	./DE_inv_test.py

%.net: %.sch
	gnetlist -g spice $< -o $@

%.raw: %.cir
	ngspice -r XX -b $<

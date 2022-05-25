SIMS= tran_binary.raw tran_ascii.raw dc_binary.raw dc_ascii.raw dc_dc_ascii.raw dc_dc_binary.raw ac_ascii.raw ac_binary.raw noise_ascii.raw noise_binary.raw



all: $(SIMS)

%.raw: %.cir
	- ngspice -b $<
	mv rawspice.raw	$@

clean:
	rm -f *raw
	rm -f *~
	rm -f *err
	rm -f *log
	rm -f *pid  
	rm -f commonrc gnetlistrc plot.cir RC2.plot.cir RC2.txt.res RC2.cir
	rm -f load_plot.cir

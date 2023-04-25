#!/usr/bin/python2.7

from pylab import *
sys.path.append("../src/")
import spice_read

plotlist = spice_read.spice_read("../test/complicated_binary.raw").get_plots()

plot2 = plotlist[2]
x = plot2.get_scalevector().get_data()

for v in plot2.get_datavectors():
    plot(x, v.get_data(), label=v.name)

title("Plottest")
grid()
legend()
savefig("short_test.png")
close()
    

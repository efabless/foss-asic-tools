#!/usr/bin/python2.7

import sys
from pylab import *

sys.path.append("../src/")
import spice_read

sys.path.append("../src/")



def test1():
    ### Test1: Transient Data
    filename = "../test/tran_binary.raw"
    plotlist = spice_read.spice_read(filename).get_plots()

    # get the first plot
    p = plotlist[0]

    xv= p.get_scalevector()
    x = xv.get_data()
    for v in p.get_datavectors():
        if v.type == "voltage":
            plot(x,v.get_data(), label=v.name)
    grid()
    legend()
    title("Test1: " + filename)
    savefig("tran_binary1.png")
    close()

    for v in p.get_datavectors():
        if v.type == "current":
            plot(x, v.get_data(), label=v.name)
    title("Test1:" + filename)
    grid()
    savefig("tran_binary2.png")
    close()



def test2():
    ### Test1: AC-Data
    ### Test1: Transient Data
    filename = "../test/ac_binary.raw"
    plotlist = spice_read.spice_read(filename).get_plots()

    # get the first plot
    p2 = plotlist[0]
    f= p2.get_scalevector().get_data()

    title("Test2: " + filename)
    for v in p2.get_datavectors():
        if v.type == "voltage":
            semilogx(f,v.get_data(),label=v.name)
    grid()
    legend()
    savefig("ac_binary1.png")
    close()

    title("Test2:" + filename)
    for v in p2.get_datavectors():
        if v.type == "voltage":
            plot(v.get_data().real, v.get_data().imag, label=v.name)
    grid()
    legend()
    savefig("ac_binary2.png")
    close()



def test3():
    ### Test3: complicated file, read second dc plot
    filename = "../test/complicated_binary.raw"
    plotlist = spice_read.spice_read(filename).get_plots()

    # get the second plot
    p2 = plotlist[1]
    x= p2.get_scalevector().get_data()

    title("Test3: " + filename)
    for v in p2.get_datavectors():
        plot(x,v.get_data(),label=v.name)
    grid()
    legend()
    savefig("complicated_dc_binary1.png")
    close()
    
#################### MAIN ####################
test1()
test2()
test3()


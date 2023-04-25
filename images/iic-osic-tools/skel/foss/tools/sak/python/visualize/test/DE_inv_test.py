#!/usr/bin/python

import scipy
import sys
import os
import pylab
import string

sys.path.append("../src")
import diffev
import spice_read

def rc_filter(f, R1=1, C1=1, R2=1, C2=1):
    ZC1 = 1.0/(1j*2*scipy.pi*f*C1)
    ZC2 = 1.0/(1j*2*scipy.pi*f*C2)
    ZC1C2R2 = 1/((1/ZC1)+1/(ZC2+R2))
    U_N1 = ZC1C2R2/(ZC1C2R2+R1)
    out = U_N1*ZC2/(R2+ZC2)
    return out

def problem1(vec, plot=0):
    dv = {"M1_Length": str(vec[0]),
          "M1_Width":  str(vec[1]),
          "M2_Length": str(vec[2]),
          "M2_Width":  str(vec[3]),
          }
    open(SPICE_FILE,"wt").write(template.safe_substitute(dv))
    os.system("ngspice -b inv.cir >/dev/null 2>/dev/null")

    p = spice_read.spice_read("inv.raw").get_plots()[0]
    uin = p.get_scalevector().get_data()
    icross = -p.get_datavector(0).get_data()
    uout = p.get_datavector(1).get_data()

    center_v=int(len(uin)/2)
    ## cost function
    ## maximum current should near the input voltage center
#    cost0=abs( sum(icross[:center_v] < icross[center_v]) \
#               - sum(icross[center_v+1:] < icross[center_v]))/len(uin)
    ## low cost for optimization
    cost1=abs((icross[center_v] - 0.001)/0.001); # i_cross = 1mA
    cost2=abs((uout[center_v] - 1.65)/1.65);     # v_out = vcc/2
    cost =  cost1 + cost2

    if plot:
        print( "Cost: ", cost, "  ", end="")
        for k,v in dv.items():
            print( k + ":", v, end="" )
        print( "" )
        pylab.plot(uin, uout, label = "V(out) [V]")
        pylab.plot(uin, icross*1000, label = "I(V2) [mA]")
        pylab.plot([1.65,1.65], [0.3,3.0], label="V(in)=1.65V")
        pylab.plot([1,2.3], [1.65,1.65], label="V(out)=1.65V")
        pylab.plot([1,2.3], [1.0,1.0], label="I(V2)=1mA")
        pylab.xlabel("V(in) [V]")
        pylab.legend()
        pylab.title("Optimized circuit results")
        pylab.grid()
        pylab.savefig("DE_inv_test.png")
        pylab.close()
    return cost


####################

SPICE_TEMPLATE = "inv.template"
SPICE_FILE = "inv.cir"
template = string.Template(open(SPICE_TEMPLATE).read())

lbound = scipy.array([1e-6, 50e-6, 1e-6, 50e-6])
ubound = scipy.array([10e-6, 500e-6, 10e-6, 500e-6])
# TODO: should this be coerced to int, so not floats?
vec = (lbound + ubound)/2

## For tests without DE
## problem1(vec,plot=1)
## sys.exit()

de = diffev.DiffEvolver.frombounds(problem1, lbound, ubound, 40)
de.set_boundaries(lbound, ubound, mode='mirror')

for x in range(100):
    de.solve(1)
    problem1(de.best_vector, plot=1)

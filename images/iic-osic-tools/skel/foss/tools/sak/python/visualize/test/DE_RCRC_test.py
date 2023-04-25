#!/usr/bin/python

import scipy
import sys
import pylab

sys.path.append("../src")
import diffev

def rc_filter(f, R1=1, C1=1, R2=1, C2=1, R3=1, C3=1):
#  in---R1--+--R2--+--R3--+--out
#           |      |      |
#           C1     C2     C3
#           |      |      |
#      ------------------------
    ZC1 = 1.0/(1j*2*scipy.pi*f*C1)
    ZC2 = 1.0/(1j*2*scipy.pi*f*C2)
    ZC3 = 1.0/(1j*2*scipy.pi*f*C3)
    Z_C2R3C3 = 1/((1/ZC2)+1/(ZC3+R3))
    Z_C1R2C2R3C3 = 1/((1/ZC1)+1/(Z_C2R3C3+R2))
    U_N1 = Z_C1R2C2R3C3/(Z_C1R2C2R3C3+R1)
    U_N2 = U_N1 * Z_C2R3C3/(Z_C2R3C3+R2)
    U_N3 = U_N2 * ZC3/(R3+ZC3) 
    return U_N3

def problem1(vec, plot=0):
    R1 = 10**(vec[0]*3+3)  # 1k to 1Meg
    C1 = 10**(vec[1]*6-9)  # 1n to 1m
    R2 = 10**(vec[2]*3+3)  # 1k to 1Meg
    C2 = 10**(vec[3]*6-9)  # 1n to 1m
    R3 = 10**(vec[4]*3+3)  # 1k to 1Meg
    C3 = 10**(vec[5]*6-9)  # 1n to 1m

    f = 10**scipy.linspace(0,6,101)
    out = abs(rc_filter(f, R1, C1, R2, C2, R3, C3))
    fc = 1000
    constraint = scipy.sum( (f <= fc)* (out < 0.7)*10000.0 )
    cost = scipy.sum((f > fc) * out)
    if plot:
        print( "Cost:", cost+constraint, "  R1=", R1, "  C1=", C1, "  R2=", R2, "  C2=", C2, "  R3=", R3, "  C3=", C3 )
        pylab.loglog(f,out,label="response")
        pylab.loglog(scipy.array([1,fc]),scipy.array([2.0**-0.5,2.0**-0.5]), label="constraint")
        pylab.legend()
        pylab.title("optimized frequency response: fc="+str(fc))
        pylab.grid()
        pylab.savefig("DE_RCRC_test.png")
        pylab.close()
    return cost + constraint


####################

lbound = scipy.zeros(6)
ubound = scipy.ones(6)
de = diffev.DiffEvolver.frombounds(problem1, lbound, ubound, 50)
de.set_boundaries(lbound, ubound, mode='mirror')

for x in range(500):
    de.solve(10)
    problem1(de.best_vector, plot=1)

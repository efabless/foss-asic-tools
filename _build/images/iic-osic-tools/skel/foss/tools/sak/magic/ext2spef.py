#!/usr/bin/env python3
#
# ext2spef.py --- Special-purpose application that reads a .ext file
# from a metal test layout for openrcx extracted by magic, and writes
# out the equivalent SPEF file.
#
# Note that this only works for the particular type of layout used for
# openrcx calibration, which consists of many overlapping metal wires
# with labels on each end.  Each label references the metal layer,
# position, and dimensions, with a "_BL" suffix denoting the second
# end.  The net name is derived from the pin name without the "_BL"
# suffix.

import os
import sys
import re
import math
import subprocess

# To do:  Run subprocess to extract the layout from GDS using magic

def usage():
    print('ext2spef.py <ext_file> <spef_file>')

def convert_file(in_file, out_file):

    # NOTE:  Because the layout is flat, there should be no "merge" lines
    # in the .ext file to process.  "port" entries are not meaningful, as
    # all labels are ports, and for this specific type of layout, the
    # second wire end can be determined by adding the "_BL" suffix.

    cscale = 1.0
    portdict = {}
    rvalues = []

    with open(in_file, 'r') as ifile:
        # Don't read all lines at once, as this file can be very large
        # Do it line by line
        for line in ifile:
            tokens = line.split()
            if len(tokens) == 0:
                continue
            match tokens[0]:
                case 'cap':
                    net1 = tokens[1].strip('"')
                    if net1.endswith('_BL'):
                        net1 = net1[0:-3]
                    net2 = tokens[2].strip('"')
                    if net2.endswith('_BL'):
                        net2 = net2[0:-3]
                    cap = float(tokens[3]) * cscale
                    # Note that SPEF requires the coupling cap to appear
                    # in the entries for both nets.
                    netprops = portdict[net1]
                    netdict = netprops[4]
                    netdict[net2] = cap
                    netprops[3] = netprops[3] + cap
                    netprops = portdict[net2]
                    netdict = netprops[4]
                    netdict[net1] = cap
                    netprops[3] = netprops[3] + cap
                case 'node':
                    netname = tokens[1].strip('"')
                    if netname.endswith('_BL'):
                        netname = netname[0:-3]
                    subcap = float(tokens[3]) * cscale
                    # This file will only have one entry pair in the area,
                    # perimeter sets, from which the L/W can be calculated
                    # and from that, the resistance of the line.
                    for i in range(54, 7, -2):
                        if tokens[i] != '0':
                            p = int(tokens[i])
                            a = int(tokens[i - 1])
                            ridx = int((i - 8) / 2)
                            s = math.sqrt(p * p - 16 * a)
                            squares = (p + s) / (p - s)
                            res = squares * rvalues[ridx]
                            break
                    coupling = {}
                    portdict[netname] = [0, subcap, res, subcap, coupling]
                case 'equiv':
                    continue
                case 'port':
                    continue
                case 'resistclasses':
                    for token in tokens[1:]:
                        rvalues.append(float(token))
                case 'scale':
                    cscale = float(tokens[2])
                case 'tech':
                    print('Found technology ' + tokens[1])

    print('Done reading and processing .ext file')

    with open(out_file, 'w') as ofile:
        name = os.path.split(in_file)[0]
        print('*SPEF "IEEE 1481-1998"', file=ofile)
        print('*DESIGN "' + name + '"', file=ofile)
        print('*VENDOR "Efabless, Inc."', file=ofile)
        print('*PROGRAM "ext2spef.py"', file=ofile)
        print('*VERSION "1.0"', file=ofile)
        print('*DIVIDER /', file=ofile)
        print('*DELIMITER :', file=ofile)
        print('*BUS_DELIMITER []', file=ofile)
        print('*C_UNIT 1.00000 FF', file=ofile)
        print('*R_UNIT 1.00000 OHM', file=ofile)
        print('', file=ofile)
        print('', file=ofile)
        print('*NAME_MAP', file=ofile)

        # Set all of the net index abbreviations
        i = 0
        cidx = 0
        ridx = 0

        for net, netprops in portdict.items():
            netprops[0] = i
            i = i + 2
            print('*' + str(i) + ' ' + net, file=ofile)
            print('*' + str(i + 1) + ' ' + net + '_BL', file=ofile)

        # Now output the entry for each net
        for net, netprops in portdict.items():
            print('', file=ofile)
            i = netprops[0]
            nnum = '*' + str(i)
            nnump = '*' + str(i + 1)
            # Total capacitance is in aF ; convert to fF
            cvalue = "{:.6f}".format(netprops[3] / 1000.0)
            print('*D_NET ' + nnum + ' ' + cvalue, file=ofile)
            print('*CONN', file=ofile)
            print('*P ' + nnum + ' O', file=ofile)
            print('*P ' + nnump + ' I', file=ofile)
            print('*CAP', file=ofile)
            # Magic's capacitances are in aF;  convert to fF
            cvalue = "{:.6f}".format(netprops[1] / 1000.0)
            print(str(cidx) + ' ' + nnump + ' ' + cvalue, file=ofile)
            cidx = cidx + 1
            for cnet, cval in netprops[4].items():
                cnetprops = portdict[cnet]
                nnumc = '*' + str(cnetprops[0])
                cvalue = "{:.6f}".format(cval / 1000.0)
                print(str(cidx) + ' ' + nnump + ' ' + nnumc + ' ' + cvalue, file=ofile)
                cidx = cidx + 1       
  
            print('*RES', file=ofile)
            # Magic's capacitances are in mOhm;  convert to Ohm
            rvalue = "{:.6f}".format(netprops[2] / 1000.0)
            print(str(ridx) + ' ' + nnump + ' ' + nnum + ' ' + rvalue, file=ofile)
            ridx = ridx + 1
            print('*END', file=ofile)

    print('Done writing .spef file')

if __name__ == '__main__':

    if len(sys.argv) == 1:
        print("No options given to ext2spef.py.")
        usage()
        sys.exit(0)

    optionlist = []
    arguments = []

    for option in sys.argv[1:]:
        if option.find('-', 0) == 0:
            optionlist.append(option)
        else:
            arguments.append(option)

    if len(arguments) != 2:
        print("Wrong number of arguments given to ext2spef.py.")
        usage()
        sys.exit(0)

    inpath = arguments[0]
    outpath = arguments[1]

    if not os.path.isfile(inpath):
        print('No such source file ' + inpath)
        sys.exit(1)

    print('Input file = ' + inpath)
    print('Output file = ' + outpath)

    convert_file(inpath, outpath)

    print('Done.')
    exit(0)

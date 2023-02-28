# -*- coding: utf-8 -*-
"""
(c) 2023 Jakob Ratschenberger
Johannes Kepler University Linz, Institute for Integrated Circuits

Script to change a spice netlist to the ALIGN .sp format.

"""
import sys 
import argparse

#use a parser to parse the cmd line variables
parser = argparse.ArgumentParser(description="Converts a spice netlist to the ALIGN format.", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("src", help="Source file")
parser.add_argument("-d","--dest", default="src", help="Destination file")
args = vars(parser.parse_args())

src_file = args["src"] #get the name of the src file
#set the destination file name
dest_file = ""
if args["dest"] != "src":
    dest_file = args["dest"]
else:
    dest_file = src_file[0:-7]+"sp"
    

#read the scr file and 
#merge devices with multiple lines
#new line starts with +    
file = open(src_file)
lines = []
for line in file:
    if line.startswith("+ "):
        last = lines.pop(-1)
        last = last + line[1:-1]
        lines.append(last)
    else:
        lines.append(line)

file.close()


def find_subckts(lines):
    sub_circ = []
    act_sub_start = 0
    act_sub_name = ""
    in_subckt = False

    for (n,line) in zip(range(len(lines)),lines):
        if line.startswith(".subckt") and not in_subckt:
            act_sub_name = line.split(" ")[1]
            act_sub_start = n
            in_subckt = True
        elif line.startswith(".ends") and in_subckt:
            in_subckt = False
            sub_circ.append([act_sub_name, act_sub_start, n])
    return sub_circ

sub_circ = find_subckts(lines)
if len(sub_circ)>1: #more than one subcirc
    new_lines = []
    for sub in reversed(sub_circ):
        for n in range(sub[1],sub[2]):
            new_lines.append(lines[n])
        new_lines.append(".ends")
        new_lines.append("\n")
    new_lines.append(".end")

    lines = new_lines

#dict for the legal devices and device params.
legal = {
    "XM" : ["L","W","nf","m", "stack"],
    "M" : ["L","W","nf","m", "stack"],
    "XC" : ["L", "W", "m"],
    "C" : ["L", "W", "m"]
    }


#split a line by whitespaces
#except when the whitespaces are in between ' '
# => needed to split the parameters of a device
def split(line):
    start = 0
    in_param = False
    splittet = []
    for (i,c) in zip(range(len(line)),line):
        if c==" " and not in_param:
            splittet.append(line[start:i])
            start = i+1
        if c == "'":
            in_param = not in_param
    splittet.append(line[start:])     
    return splittet

def get_dev(line):
    dev = line.split()
    dev = dev[0]
    for key in legal.keys():
        if dev.startswith(key):
            return key
    raise KeyError(f"Error: Device {dev} not supported!")

inSubckt = False
#delete illegal parameters
for (line_n,line) in zip(range(len(lines)),lines):
    if line.startswith(".subckt"):
        inSubckt = True
    if line.startswith(".ends"):
        inSubckt = False
       
    #only change line if it is a device
    if inSubckt and not (len(line)<2 or line.startswith(".") or line.startswith("*") or line.startswith("x")):
        dev = get_dev(line) #device descriptor
        try: #try if device is supported
            splittet = split(line) #split line to get parameters
            
            if splittet[0].startswith("XC"):#if act. device is a Cap change descriptor
                splittet[0] = "C"+splittet[0][2:]

            indx_rm = [] #store which params have to be removed
            index_W = 0
            nf = 0
            for (i,w) in zip(range(len(splittet)),splittet):
                indx = w.find("=") #find a parameter
                if w[0] in {'W', 'L'}:
                    w = w+"e-6" 
                    splittet[i]=w
                    index_W = i
                if dev in ["XM", "M"]:
                    #set nf=2 for ALIGN
                    if w.startswith('nf='):
                        nf=int(w[3:])
                        assert nf%2==0, f"Error: nf odd not supported! [Device {splittet[0]}]"
                        splittet[index_W] = "W="+str(round(float(splittet[index_W][2:])*1e6/nf,2))+"e-6"
                        w='nf=2'
                        splittet[i]=w
                    #half the multiplier to have the same circuit
                    if w.startswith('m='):
                        m = int(w[2:])
                        assert m==1, f"Error: m > 1 not supported! [Device {splittet[0]}]"
                        w = 'm=' + str(int(nf/2))
                        splittet[i] = w

                #if a parameter were found and the param isn't legal
                #store the index 
                if indx>=0 and w[0:indx] not in legal[dev]:
                    indx_rm.append(i)
                    
            #delete all illegal params
            for index in sorted(indx_rm, reverse=True):
                del splittet[index]
                
        except KeyError:
            print(f"Error: Device {dev} not supported!")
            sys.exit(1)
        
        #change the actual modified line
        lines[line_n] = " ".join(splittet)

#wite destination file            
with open(dest_file, 'w') as f:
    for line in lines:
        if line[-1] == '\n':
            f.write(f"{line}")
        else:
            f.write(f"{line}\n")             
                


                    
                
        
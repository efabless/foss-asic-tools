# -*- coding: utf-8 -*-
"""
(c) 2023 Jakob Ratschenberger
Johannes Kepler University Linz, Institute for Integrated Circuits

Script to change a spice netlist to the ALIGN .sp format.

"""
import sys 
import argparse

debug = False #debug mode

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

#list for the legal devices
legal = ["XM","M"]
#list for the legal schematic parameters
legal_param = ["Wp", "Wn", "L"]
class MOS:
    def __init__(self, line):
        self.mos_dict = {
        "ID" : [],
        "Nd" : [],
        "Ng" : [],
        "Ns" : [],
        "Nb" : [],
        "model" : [],
        "W" : [],
        "L" : [],
        "nf" : [],
        "m" : []
        }
        self.__spice_to_var(line)
        if debug:
            print(self.mos_dict)
        assert int(self.mos_dict["nf"])%2==0, f"Error: nf odd not supported! [Device {self.mos_dict['ID']}]"
        assert int(self.mos_dict["m"])==1, f"Error: m > 1 not supported! [Device {self.mos_dict['ID']}]"

    def update_param(self, key, value):
        if key == "L":
            self.mos_dict["L"] = str(float(value))
        if key == "Wn" and "nfet" in self.mos_dict["model"]:
            self.mos_dict["W"] = str(float(value)*int(self.mos_dict["nf"]))
        if key == "Wp" and "pfet" in self.mos_dict["model"]:
            self.mos_dict["W"] = str(float(value)*int(self.mos_dict["nf"]))

    def __spice_to_var(self,line):
        splittet = line.split(" ")
        self.mos_dict["ID"] = splittet[0]
        self.mos_dict["Nd"] = splittet[1]
        self.mos_dict["Ng"] = splittet[2]
        self.mos_dict["Ns"] = splittet[3]
        self.mos_dict["Nb"] = splittet[4]
        self.mos_dict["model"] = splittet[5]
        
        for (n, x) in zip(range(len(splittet)),splittet):  
            
            if "=" in x: #parameter
                param_name = x[:x.find("=")]
                if param_name in self.mos_dict.keys():
                    self.mos_dict[param_name] = x[x.find("=")+1:]

    def write_mos(self):
        #set m and nf for align
        self.mos_dict["W"] = str(round(float(self.mos_dict["W"])/int(self.mos_dict["nf"]),2))
        self.mos_dict["m"] = str(int(self.mos_dict["nf"])//2)
        self.mos_dict["nf"] = "2"
        v = list(self.mos_dict.values())
        return f"{v[0]} {v[1]} {v[2]} {v[3]} {v[4]} {v[5]} W={v[6]}e-6 L={v[7]}e-6 nf={v[8]} m={v[9]}"


def get_dev(line):
    dev = line.split()
    dev = dev[0]
    for l in legal:
        if dev.startswith(l):
            return l
    raise KeyError(f"Error: Device {dev} not supported!")

inSubckt = False
devs = []
params = []
n = 0
while(n<len(lines)):
    line = lines[n]
    if debug: 
        print(line+"\n")
    if line.startswith(".subckt"):
        inSubckt = True
    if line.startswith(".ends"):
        for d in devs:
            for p in params:
                d.update_param(p[0], p[1])
            lines.insert(n, d.write_mos())
            n += 1
        inSubckt = False
        devs = []
        params = []
    
    if inSubckt:
        if not (line.startswith(".") or line.startswith("*") or line.startswith("x")):
            try: #try if device is supported
                dev = get_dev(line)
                devs.append(MOS(line))
                lines.pop(n)
                n -= 1

            except KeyError:
                print(f"Error: Device {dev} not supported!")
                sys.exit(1)
        elif line.startswith(".param"):
            p = line.split(" ")
            p = p[1]
            p = p.split("=")
            assert p[0] in legal_param, f"Parameter {p[0]}={p[1]} not supported!"
            params.append([p[0], p[1]])
            lines.pop(n)
            n -= 1
    
    n += 1

#wite destination file            
with open(dest_file, 'w') as f:
    for line in lines:
        if line[-1] == '\n':
            f.write(f"{line}")
        else:
            f.write(f"{line}\n")             
                


                    
                
        
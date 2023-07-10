# -*- coding: utf-8 -*-
# ========================================================================
# SPDX-FileCopyrightText: 2023 Jakob Ratschenberger
# Johannes Kepler University, Institute for Integrated Circuits
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
#
# This script generates the ALIGN .sp format, from a spice netlist.
#
# The following devices are supported:
#    -sky130_fd_pr__nfet_01v8
#    -sky130_fd_pr__pfet_01v8
#
# A subcircuit component must start with the component identifier "x".
# ========================================================================

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
# Returns a list of all subcircuits in lines
# Each element includes:
#  {"Subcircuit-Name", 
#   Line-number of subcircuit start,
#   Line-number of subcircuit end}

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
# check if there is more than one subcircuit
# if so, reverse the order of the subcircuits
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

#class for spice-mosfets
class MOS:
    #init with a spice mos definition
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

    #update legal circuit parameters
    def update_param(self, key, value):
        if key == "L":
            self.mos_dict["L"] = str(float(value))
        if key == "Wn" and "nfet" in self.mos_dict["model"]:
            self.mos_dict["W"] = str(float(value)*int(self.mos_dict["nf"]))
        if key == "Wp" and "pfet" in self.mos_dict["model"]:
            self.mos_dict["W"] = str(float(value)*int(self.mos_dict["nf"]))

    #save line in dict
    def __spice_to_var(self,line):
        splittet = line.split(" ")
        self.mos_dict["ID"] = splittet[0]
        self.mos_dict["Nd"] = splittet[1]
        self.mos_dict["Ng"] = splittet[2]
        self.mos_dict["Ns"] = splittet[3]
        self.mos_dict["Nb"] = splittet[4]
        self.mos_dict["model"] = splittet[5]
        
        #get parameters
        for (n, x) in zip(range(len(splittet)),splittet):  
            if "=" in x: #parameter
                param_name = x[:x.find("=")]
                if param_name in self.mos_dict.keys():
                    self.mos_dict[param_name] = x[x.find("=")+1:]

    #write a line in the ALIGN format
    def write_mos(self):
        #set m and nf for align
        self.mos_dict["W"] = str(round(float(self.mos_dict["W"])/int(self.mos_dict["nf"]),2))
        self.mos_dict["m"] = str(int(self.mos_dict["nf"])//2)
        self.mos_dict["nf"] = "2"
        v = list(self.mos_dict.values())
        return f"{v[0]} {v[1]} {v[2]} {v[3]} {v[4]} {v[5]} W={v[6]}e-6 L={v[7]}e-6 nf={v[8]} m={v[9]}"


def get_dev(line):
    #returns the device descriptor - if legal
    dev = line.split()
    dev = dev[0]
    for l in legal:
        if dev.startswith(l):
            return l
    raise KeyError(f"Error: Device {dev} not supported!")

#########################################################
# Main - part
# go through each subcircuit and update each legal device
#########################################################
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
        # if end of subcircuit reached
        # update the parameters and 
        # insert the updated devices
        # into lines
        for d in devs:
            for p in params:
                d.update_param(p[0], p[1])
            lines.insert(n, d.write_mos())
            n += 1
        inSubckt = False
        devs = []
        params = []
    
    if inSubckt:
        if not (line.startswith(".") or line.startswith("*") or line.startswith("x")): #get device
            try: #try if device is supported
                dev = get_dev(line) #check if device is supported
                devs.append(MOS(line)) #save the device
                lines.pop(n) #delete the actual line
                n -= 1

            except KeyError:
                print(f"Error: Device {dev} not supported!")
                sys.exit(1)

        elif line.startswith(".param"): #get parameter
            p = line.split(" ")
            p = p[1] #get the parameter identifier and value
            p = p.split("=") #split the identifier and value
            assert p[0] in legal_param, f"Parameter {p[0]}={p[1]} not supported!"
            params.append([p[0], p[1]])
            lines.pop(n) #delete the actual line
            n -= 1
    
    n += 1

#wite destination file            
with open(dest_file, 'w') as f:
    for line in lines:
        if line[-1] == '\n':
            f.write(f"{line}")
        else:
            f.write(f"{line}\n")             
                


                    
                
        
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
# This script places ports at labels in a .mag file.
#
# ========================================================================

import sys 
import argparse

#use a parser to parse the cmd line variables
parser = argparse.ArgumentParser(description="Places ports at labels.", formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("src", help="Source file")
parser.add_argument("-d","--dest", default="src", help="Destination file")
args = vars(parser.parse_args())

src_file = args["src"] #get the name of the src file
#set the destination file name
dest_file = ""
if args["dest"] != "src":
    dest_file = args["dest"]
else:
    dest_file = src_file[0:-4]+"_lvs.mag"
    

#read the scr file and 
#find the labels
file = open(src_file)
lines = []
labels = []
line_numbers = []
n = 0
for line  in file:
    if line.startswith("flabel"):
        splittet = line.split()
        labels.append(splittet[-1])
        line_numbers.append(n)
    lines.append(line)
    n += 1

file.close()

labels = list(set(labels))
line_numbers.reverse()
for n in line_numbers:
    splittet = lines[n].split()
    index = labels.index(splittet[-1])
    lines.insert(n+1, "port " + str(index) + " nsew")


#wite destination file            
with open(dest_file, 'w') as f:
    for line in lines:
        if line[-1] == '\n':
            f.write(f"{line}")
        else:
            f.write(f"{line}\n")             
                


                    
                
        
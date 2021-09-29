#!/usr/bin/env python3
# Copyright 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
import os
import argparse

def list_macros(directory, output):
    neededfile = [os.path.join(directory, f) for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f)) and str(f).endswith(".magic.typelist") and os.path.basename(f).split(".",1)[0] != "caravel"][0]

    macro_list=[]
    printArr=[]
    if(os.path.exists(neededfile)):
        print(neededfile)
        FileOpener = open(neededfile, "r")
        if FileOpener.mode == 'r':
            Content = FileOpener.read()
        FileOpener.close()
        for cell in Content.split(" "):
            if not cell.startswith("sky130_fd_sc_"):
                macro_list.append(cell)
        printArr.append("Macros Count: "+ str(len(macro_list)))
        printArr.append("Macros: " + " ".join(macro_list))
        for line in printArr:
            print(line)
        outputFileOpener = open(output,"w")
        outputFileOpener.write("\n".join(printArr))
        outputFileOpener.close()



if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='The script takes a checks output directory from running the fuzzy checks in the Precheck, \
        and lists the number of macros in the user_project_wrapper.')

    parser.add_argument('--directory', '-d',required=True,
                        help='The checks directory.')

    parser.add_argument('--output', '-o',default=None,
                    help="outputs the list of macros")


    args = parser.parse_args()
    directory = args.directory
    output = args.output
    if output is None:
        output = str(directory+"/macro_list.txt")
    list_macros(directory,output)

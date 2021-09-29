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

# Prerequisite: pip install pyyaml

import argparse
import subprocess
import os
import yaml

parser = argparse.ArgumentParser(
        description="Parses a summary report into info.yaml")


parser.add_argument('--summary_report', '-s', action='store', default="final_summary_report.csv",
                help="The csv file to be parsed, defaults to final_summary_report.csv")

parser.add_argument('--info_yaml', '-i', action='store', default="info.yaml",
                help="The info.yaml file, defaults to info.yaml")

parser.add_argument('--target_path', '-t', action='store', default=None,
                help="The run path, will be used to search for any missing files.")

args = parser.parse_args()
summary_report = args.summary_report
info_yaml = args.info_yaml
target_path = args.target_path
if target_path is None:
    target_path = str(os.getcwd())

stats= ["DIEAREA_mm^2", "CellPer_mm^2", "cell_count","STD_CELL_LIBRARY"]
def findIdx(header, label):
    for idx in range(len(header)):
        if label == header[idx]:
            return idx
    else:
        return -1
def parseCSV(csv_file):
    map_out = dict()
    csvOpener = open(csv_file, 'r')
    csvData = csvOpener.read().split("\n")
    headerInfo = csvData[0].split(",")
    designNameIdx = findIdx(headerInfo, "design")
    if designNameIdx == -1:
        print("invalid report. No design names.")
        exit(-1)
    for i in range(1, len(csvData)):
        if len(csvData[i]):
            entry = csvData[i].split(",")
            designName=entry[designNameIdx]
            for idx in range(len(headerInfo)):
                if idx != designNameIdx:
                    if designName not in map_out.keys():
                        map_out[designName] = dict()
                    map_out[designName][headerInfo[idx]] = str(entry[idx])
    return map_out

def read_yaml(yaml_file):
    with open(yaml_file,'r+',encoding='utf-8') as f:
        list_doc = yaml.load(f, Loader=yaml.FullLoader)
    return list_doc

def write_yaml(yaml_file,list_doc):
    with open(yaml_file,'w+',encoding='utf-8') as f:
        yaml.dump(list_doc, f)

designs_map=parseCSV(str(target_path)+"/"+str(summary_report))

yaml_map = read_yaml(str(target_path)+"/"+str(info_yaml))


def form_map(designs_map,stats):
    write_map =dict()
    for design in designs_map:
        design_map = designs_map[design]
        design_name = design_map["design_name"]
        write_map[design_name] = dict()
        for stat in stats:
            write_map[design_name][stat]=design_map[stat]
    return write_map

write_map = form_map(designs_map, stats)

if "stats" not in yaml_map["project"]:
    yaml_map["project"]["stats"] = write_map
    write_yaml(str(target_path)+"/"+str(info_yaml),yaml_map)
    print("Done.")
else:
    print("stats already exists")
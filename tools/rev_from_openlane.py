#!/bin/python3
# For HTTP stuff
import urllib3

# import Pyyaml, either C-backed classes or python only.
from yaml import load, dump
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper

import yaml


OPENLANE_TOOL_METADATA_URL_FSTR = "https://raw.githubusercontent.com/The-OpenROAD-Project/OpenLane/{0}/dependencies/tool_metadata.yml"
OPENLANE_DEFAULT_TAG = "ebad315d1def25d9d253eb2ec1c56d7b4e59d7ca"

def load_revisions(tag=OPENLANE_DEFAULT_TAG):
    dl_url=OPENLANE_TOOL_METADATA_URL_FSTR.format(tag)
    print(f"Loading tool metadata from:\"{dl_url}\"")
    http = urllib3.PoolManager()
    res = http.request("GET", dl_url)
    if res.status!=200:
        print(f"Loading file failed with HTTP status{res.status}!")
        return None
    data = yaml.load(res.data, Loader=Loader)
    return data

def get_revision(data, tool_name):
    result = [x for x in data if x['name'] == tool_name]
    if len(result) < 1:
        return None
    if len(result) > 1:
        print(f"WARNING: Multiple entries for tool{tool_name} found!")
    result = result[0]
    commit = result.get("commit")
    return commit

def read_dockerfile(path="Dockerfile"):
    with open(path, mode="r") as f:
        return f.readlines()
    return None

def write_dockerfile(df_contents, path="Dockerfile"):
    with open(path, mode="w") as f:
        f.writelines(df_contents)

# Every Dockerfile line that defines a new build-stage is defined by FROM <basename> AS <stagename>
# This greps all those lines and gives a list of stagenames
def get_existing_tools(df_contents):
    tools = list()
    for line in df_contents:
        elements = line.split()
        if len(elements)>=4 and elements[0].lower() == "from":
            tools.append(elements[3])
    return tools

def update_revision(df_contents, tool_name, new_rev):
    search_str=tool_name.upper()+"_REPO_COMMIT"
    for i,line in enumerate(df_contents):
        elem=line.split()
        if len(elem)>=2 and elem[0].upper()=="ARG" and elem[1].startswith(search_str):
            print(f"Updated line {i}")
            df_contents[i]="ARG " + search_str + "=\"" + new_rev + "\"\n"
            return True
    return False

if __name__ == "__main__":
    data = load_revisions()
    if data is not None:
        df_contents = read_dockerfile()
        if df_contents is not None:
            tools = get_existing_tools(df_contents)
            for tool in tools:
                new_rev=get_revision(data, tool)
                if new_rev is not None:
                    print(f"Found for {tool}: {new_rev}")
                    if not update_revision(df_contents, tool, new_rev):
                        print( "###########################################################")
                        print(f"ERROR: updating the revision for {tool} failed!")
                        print( "###########################################################")
        #print(df_contents)
            print(f"Updating openlane to revision {OPENLANE_DEFAULT_TAG}.")
            if not update_revision(df_contents, "openlane", OPENLANE_DEFAULT_TAG):
                print("###########################################################")
                print("ERROR: updating the revision for openlane failed!")
                print("###########################################################")            
            write_dockerfile(df_contents)
    #print([x for x in data if x['name'] == 'drcu'][0])
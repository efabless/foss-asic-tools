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
import argparse

OPENLANE_TOOL_METADATA_URL_FSTR = "https://raw.githubusercontent.com/The-OpenROAD-Project/OpenLane/{0}/dependencies/tool_metadata.yml"

def load_revisions(tag="", url_fstr=OPENLANE_TOOL_METADATA_URL_FSTR):
    dl_url=url_fstr.format(tag)
    http = urllib3.PoolManager()
    res = http.request("GET", dl_url)
    if res.status!=200:
        print(f"Loading file failed with HTTP status {res.status}!")
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
    prs = argparse.ArgumentParser(description="Update the tool commits/revisions from the openlane-Repository")
    prs.add_argument("--url", action="store", type=str, required=False, default=OPENLANE_TOOL_METADATA_URL_FSTR, help="This is the URL from which the metadata YAML file is loaded. Can include {0}, where the commit/tag of the repository is added.")
    prs.add_argument("--dry-run", action="store_true", help="Disable writing the Dockerfile, just print the results.")
    prs.add_argument("--file-path", action="store", type=str, default="./Dockerfile", help="Change the location of the Dockerfile involved.")
    prs.add_argument("commit", metavar="commit", type=str, help="The commit (can be tag or hash) to load the metadata YAML from.")

    args = prs.parse_args()

    print(f"Loading tool metadata from: \"{args.url.format(args.commit)}\"")
    data = load_revisions(tag=args.commit, url_fstr=args.url)
    if data is not None:
        print(f"Loading Dockerfile from: \"{args.file_path}\"")
        df_contents = read_dockerfile(path=args.file_path)
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
            print(f"Updating openlane to revision {args.commit}.")
            if not update_revision(df_contents, "openlane", args.commit):
                print("###########################################################")
                print("ERROR: updating the revision for openlane failed!")
                print("###########################################################")
            if not args.dry_run:
                print(f"Writing Dockerfile to {args.file_path}")
                write_dockerfile(df_contents, path=args.file_path)
    #print([x for x in data if x['name'] == 'drcu'][0])
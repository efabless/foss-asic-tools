# For HTTP stuff
import urllib3

# import Pyyaml, either C-backed classes or python only.
from yaml import load, dump
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper

import yaml

def metadata_load(tag, url_fstr):
    dl_url=url_fstr.format(tag)
    http = urllib3.PoolManager()
    res = http.request("GET", dl_url)
    if res.status!=200:
        print(f"Loading file failed with HTTP status {res.status}!")
        return None
    return res.data

def metadata_parse(raw_data):
    data = yaml.load(raw_data, Loader=Loader)
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

def metadata_write(raw_data, path="metadata.yml"):
    with open(path, mode="wb") as f:
        f.write(raw_data)
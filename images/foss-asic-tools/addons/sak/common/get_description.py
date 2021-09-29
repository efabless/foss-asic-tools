#! /usr/bin/python3

import yaml
import io
#import sys
#reload(sys)
#sys.setdefaultencoding('utf8')

#with open('info.yaml','r') as file:
with open('info.yaml','r',encoding='utf-8') as file:
    info = yaml.load(file, Loader=yaml.SafeLoader)
    if 'project' in info and 'project_id' in info['project'].keys():
        print(info['project']['description'])
    else:
        print("--none--")


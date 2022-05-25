#!/usr/bin/python
# vim: ts=4 : sw=4 : et

import sys,re,string
import ConfigParser
import os.path


#################### CONSTANTS
TRANSISTOR_TEMPLATE="""
$headline
[$partnumber]
symbol=.sym
value=$part
modelname=$part
file=$filename
refdes=$refdes
pinseq_c=1
pinseq_b=2
pinseq_e=3
pinnr_c=C
pinnr_b=B
pinnr_e=E
footprint=none
documentation=TBD2
description=TBD1
test_refdes=$test_refdes
model_status=test
"""

DIODE_TEMPLATE="""
$headline
[$partnumber]
symbol=.sym
value=$part
modelname=$part
file=$filename
refdes=$refdes
pinseq_a=1
pinseq_k=2
pinnr_a=A
pinnr_k=K
footprint=none
description=TBD
test_refdes=$test_refdes
model_status=$status
"""

OPAMP_TEMPLATE="""
$headline
[$partnumber]
symbol=opamp.sym
value=$part
modelname=$part
file=$filename
refdes=$refdes
pinseq_inp=1
pinseq_inn=2
pinseq_pp=3
pinseq_pn=4
pinseq_out=5
pinnr_inp=in+
pinnr_inn=in-
pinnr_pp=V+
pinnr_pn=V-
pinnr_out=out
footprint=none
description=TBD1
documentation=TBD2
test_refdes=$test_refdes
model_status=$status
"""



values = {"headline":"",
          "part":"",
          "number":"",
          "filename":"",
          "refdes":"D?",
          "test_refdes":"D1",
          "status":"test"}

#################### FUNCTIONS

def read_index(filename):
    index = ConfigParser.ConfigParser()
    index.read(filename)

    modelfiles = set([])

    for section in index.sections():
        if index.has_option(section, 'file'):
            modelfile = index.get(section, 'file')
            modelfiles.add(modelfile)

    return modelfiles


#################### MAIN
#tt = string.Template(TRANSISTOR_TEMPLATE)
#tt = string.Template(DIODE_TEMPLATE)
tt = string.Template(OPAMP_TEMPLATE)
PINCOUNT = 3
MODEL_REFDES = "X"
PREFIX="ADI"
NUMBER=100001
INDEX_FILE = 'indexfiles/adi_opamps.index'

#usedfiles = set([])
usedfiles = read_index(INDEX_FILE)
#print usedfiles
#xxx

files = sys.argv[1:]
files.sort()
for f in files:
    modelname = f.split('/')[-1]
    if modelname in usedfiles:
        continue
    lines = open(f,"rt").readlines()
    v = values.copy()
    for l in lines:
        subckt_match = re.match("\.subckt",l.lower())
        model_match = re.match("\.MODEL",l)
        if  subckt_match or model_match:
            toks = string.split(string.strip(l))
            if subckt_match:
                model_refdex = "X"
            else:
                model_refdes = MODEL_REFDES
            v["part"] = os.path.splitext(os.path.basename(f))[0]
#            v["part"] = toks[1]
            v["filename"] = modelname
            v["number"] = PREFIX + str(NUMBER)[1:]
            v["partnumber"] = v["part"] + '_' + v["number"]
            NUMBER = NUMBER + 1
            if re.match("\.MODEL",l):            
                v["refdes"] = MODEL_REFDES + "?"
                v["test_refdes"] = MODEL_REFDES + "1"
            else:
                v["refdes"] = "X?"
                v["test_refdes"] = "X1"
            n = len(toks)
            if n != (PINCOUNT + 2) :
                v["headline"] = "\n# Subcircuit with " + "%i" %(n-2) + " connections"
                v["status"] = "undefined"
            print tt.safe_substitute(v)
            break


            

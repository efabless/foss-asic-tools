#! /usr/bin/python
# vim: ts=4 :
# vim: sw=4 :

#From the CSV list of linear tech op-amps, fill in the data for parts in
#ltc_opamps.index for parts that are marked as
#model_status=undefined

import csv
import ConfigParser
import optparse
import string
import sys
import re

MODELDIR='model_library/ltc/opamps/'

GLOBAL_TEMPLATE="""
[GLOBAL]
MODELDIR=$modeldir
TESTDIR=$testdir
DESCRIPTION=$description
GOLDEN_CHECKSUMS=$golden_checksums
CURRENT_CHECKSUMS=$current_checksums
model_status=undefined
"""

OPAMP_TEMPLATE="""
[$section]
symbol=$symbol
value=$value
modelname=$value
file=$file
refdes=$refdes
pinseq_inp=$pinseq_inp
pinseq_inn=$pinseq_inn
pinseq_pp=$pinseq_pp
pinseq_pn=$pinseq_pn
pinseq_out=$pinseq_out
pinnr_inp=$pinnr_inp
pinnr_inn=$pinnr_inn
pinnr_pp=$pinnr_pp
pinnr_pn=$pinnr_pn
pinnr_out=$pinnr_out
footprint=$footprint
description=$description
documentation=$documentation
test_refdes=$test_refdes
model_status=$model_status
"""

def to_float(str_):
    try:
        return float(str_)
    except ValueError:
        return None

def to_int(str_):
    try:
        return int(str_)
    except ValueError:
        return None


def main(argv):
    usage = "%prog indexfile csvfile"
    parser = optparse.OptionParser(usage)
    (options, args) = parser.parse_args(argv[1:])
    if len(args) != 2:
        parser.print_usage()
        sys.exit(2)
    indexfn = args[0]
    csvfn = args[1]

    csv_data = {}
    csv_reader = csv.reader(open(csvfn))
    for rownum, row in enumerate(csv_reader):
        if rownum == 0:
            rowkeys = dict([(b, a) for a, b in enumerate(row)])
        else:
            csv_data[row[rowkeys['Part Number']]] = {
                    #other fields can be added as needed
                    'description' : row[rowkeys['Comments']]}

    index = ConfigParser.ConfigParser()
    index.read(indexfn)

    try:
        gt = string.Template(GLOBAL_TEMPLATE)
        print gt.safe_substitute(dict(index.items('GLOBAL')))
    except ConfigParser.NoSectionError:
        pass

    tt = string.Template(OPAMP_TEMPLATE)
    for section in index.sections():
        if section != 'GLOBAL':
            if index.get(section, 'model_status') in ['test', 'undefined']:
                v = dict(index.items(section))
                v['section'] = section
                csv_row = v['value']
                modelfile = open(MODELDIR + v['file'], 'r')
                for line in modelfile:
                    if re.search('\.SUBCKT', line):
                        nocomments = re.sub('\*.*$', '', line)
                        fields = nocomments.split()
                        if len(fields) != 7:
                            v['symbol'] = '.sym'
                            v['model_status'] = 'undefined'
                        break
                part_number = v['modelname']
                if part_number in csv_data:
                    if v['description'] == 'TBD1':
                        v['description'] = csv_data[part_number]['description']
            print tt.safe_substitute(v)

if __name__ == '__main__':
    main(sys.argv)

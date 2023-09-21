#! /usr/bin/python
# vim: ts=4 :
# vim: sw=4 :

#Fill in description, documentation for national semiconductor models

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


def main(argv):
    usage = "%prog indexfile"
    parser = optparse.OptionParser(usage)
    (options, args) = parser.parse_args(argv[1:])
    if len(args) != 1:
        parser.print_usage()
        sys.exit(2)
    indexfn = args[0]

    index = ConfigParser.ConfigParser()
    index.read(indexfn)

    try:
        gt = string.Template(GLOBAL_TEMPLATE)
        print gt.safe_substitute(dict(index.items('GLOBAL')))
    except ConfigParser.NoSectionError:
        pass

    tt = string.Template(OPAMP_TEMPLATE)
    for section in sorted(index.sections(), key=lambda x: x.split('_')[-1]):
        if section == 'GLOBAL':
            continue
        mfn = 'model_library/national/opamps/' + index.get(section, 'file')
        mf = open(mfn)
        desc = 'TBD1'
        for line in mf:
            match = re.search('^\*\w+\s+(.*)MACRO-MODEL', line, flags=re.I)
            if match:
                desc = match.group(1)
                break
            pat = '^\*\s*' + index.get(section, 'value') + '\s*(.*)'
            match = re.search(pat, line, flags=re.I)
            if match:
                desc = match.group(1)
                break
        index.set(section, 'description', desc)
        prefix = index.get(section, 'value')[0:2]
        pdfname = re.sub('[A-Za-z]$', '', index.get(section, 'value')).upper()
        index.set(section, 'documentation', \
            'http://www.national.com/ds/%s/%s.pdf' % (prefix.upper(), pdfname))
        v = dict(index.items(section))
        v['section'] = section
        print tt.safe_substitute(v)



if __name__ == '__main__':
    main(sys.argv)

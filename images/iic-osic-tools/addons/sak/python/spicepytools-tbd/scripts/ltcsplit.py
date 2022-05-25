#! /usr/bin/python
# vim: ts=4 :
# vim: sw=4 :

#     Copyright (C) 2009 Alan Somers
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


import sys
import re
import os.path
import glob
import optparse

class GnucapIncompatibleError(Exception):
    """Raised by the parser to indicate incompatibity with gnucap"""

FILESEP = '^\*\*\*$'
#The following syntaxes are not compatible with gnucap and should signal a
#fatal error in conversion
FATAL_STRINGS = [
#  '^\\s*J',                 #JFETs not implemented in Gnucap 0.35
#  '^[^*]*\.model .*vswitch',#VSwitch element is not documented in LTspice manual
#  '^\\s*[EFGH].*POLY',      #POLY syntax is undocumented in LTspice manual
#  '^[^*]*\\WTANH\\W',       #TANH command is different than gnucap's, but could
                             #probably be converted with some work
#  '^[^*]*VALUE.*[IV]\(',    #Action at a distance: An element's value depends 
                             #on a probe at some other node.  Gnucap can't do
                             #this.  
#  '^\\s*\.MODEL.*NPN\(.* NK\\s*=' #Gnucap does not support the NK model param
]

DELETED = set([])


def read_lib(lib_fn, basedir):
    """Read the LTC library file and separate its contents"""
    lib = open(lib_fn, 'r')
    line = lib.next()
    outfiles = set([])
    includes = {}
    while True:
        buffer = ""
        while True:
            if re.search(FILESEP, line):
                break
            try:
                line = lib.next()
            except StopIteration:
                #lib ended in between files.  Quit now
                return outfiles, includes
        #Found the start of a circuit, now get the rest, starting with the name
        try:
            while True:
                    #this file requires an include
                if re.search('^\.SUBCKT', line, re.IGNORECASE):
                    break
                buffer += line
                line = lib.next()
            #Found the circuit's name line, now extract it
            name = re.search('^\.SUBCKT\\s+(.*?)\\s+', 
                             line, re.IGNORECASE).groups()[0]
            #Gnucap does not allow - in subckt names.  Replace it with _
            new_name = re.sub('-', '_', name)
            #create a file for this new name, but make sure it's local for safety
            fn = os.path.join(basedir, new_name) + '.MOD.tmp'
            outf = open(fn, 'w')
            includes[fn] = set([])
            outfiles.add(fn)
            #Write the saved buffer to the output file
            outf.write(buffer)
            #Now output all lines until the end of this circuit
            while True:
                for f in FATAL_STRINGS:
                    if re.search(f, line, re.IGNORECASE):
                        raise GnucapIncompatibleError
                STANDARD_SUBSTITUTIONS = [
                    #LTC spice files use ; to denote inline comments.  Gnucap 
                    #uses " .  Change them with this substitution.  Also, 
                    #include leading space
                    #XXX: gnucap seems to use " in some places and ' in others.
                    #For now delete all inline comments
                    ('(^[^*][^;]*);(.*$)', '\\1'),
                    #LTSpice uses TC for the first order time coefficient; 
                    #gnucap uses TC1
                    ('(^R.*\\s)TC(=.*$)', '\\1TC1\\2'),
                    #Gnucap does not allow - in subckt names.  Replace it with _
                    (name, new_name),
                    #LTSpice assumes PMOS and NMOS models are level 1 by
                    #default, gnucap requires an explicit level assignment
                    ('(^\.MODEL .*[NP]MOS\()(?!.*LEVEL)', '\\1LEVEL=1 '),
                    #Gnucap Assumes that Q x y z w v to mean Q C B E S model, 
                    #but LTSpice means Q C B E model area.  To fix this, we 
                    #explicitly label the area
                    ('(^[\\s]*Q\\S*\\s+\\S+\\s+\\S+\\s+\\S+\\s+\\D\\S*\\s+)(\\d\\S*)(\\s*".*$|\\s*$)', '\\1 AREA=\\2 \\3')
                ]
                for pat, repl in STANDARD_SUBSTITUTIONS:
                    line = re.sub(pat, repl, line)

                inc = re.search('^[^*]*X.*?(\w+)\\s*($|\n)', line, re.IGNORECASE)
                if inc:
                    includes[fn].add(inc.groups()[0])
                outf.write(line)
                try:
                    line = lib.next()
                except StopIteration:
                    #LIB ended in the middle of a file.  Output everything we've got and quit
                    outf.close()
                    return outfiles, includes
                if re.search(FILESEP, line):
                    break
            #The file is done; close it
            outf.close()
        except GnucapIncompatibleError:
            outf.close()
            DELETED.add(outf.name)
            os.remove(outf.name)
            outfiles.discard(outf.name)
            while True:
                try:
                    line = lib.next()
                except StopIteration:
                    #LIB ended in the middle of a file.
                    return outfiles, includes
                if re.search(FILESEP, line):
                    break
    return outfiles, includes


def expand_includes(file, includes):
    try:
        tmpfile = open(file, 'r')
    except IOError:
        #A dependency was deleted.  file cannot be processed
        return
    outfn = file.split('.tmp')[0]
    outfile = open(outfn, 'w')
    outfile.write('* %s' % os.path.basename(file).split('.MOD.tmp')[0])
    for i in includes[file]:
        try:
            incfile = open(i, 'r')
        except IOError:
            #A dependency was deleted.  file cannot be processed
            outfile.close()
            os.remove(outfn)
            return
        for line in incfile:
            outfile.write(line)
        incfile.close()
    for line in tmpfile:
        outfile.write(line)


def dereference_includes(files, includes):
    processed = set([]) #set of files already processed
    def find_inc(file, processed):
        """Yield the next include to process.
        The next file to process is any file that references no files which have
        not already been processed"""
        assert not file in processed
        if includes[file] - processed == set([]):
            processed.add(file)
            yield file
        else:
            for i in includes[file] - processed:
                find_inc(i, processed)

    for file in includes:
        if not file in processed:
            for j in find_inc(file, processed):
                #j is the file to finally process
                expand_includes(j, includes)


def main(argv):
    usage = "%prog [OPTIONS] file"
    parser = optparse.OptionParser(usage)
    parser.add_option('-d', help="extract files to DIR", metavar='DIR', type='string', default=os.getcwd(), dest='dir')
    (options, args) = parser.parse_args(argv[1:])

    for lib in args:
        tmpfiles, includes = read_lib(lib, options.dir)
        dereference_includes(tmpfiles, includes)
        for file in glob.glob(os.path.join(options.dir, '*.MOD.tmp')):
            os.remove(file)


if __name__ == '__main__':
    sys.exit(main(sys.argv))

#!/usr/bin/python2.7
# vim: ts=4 :
# vim: sw=4 :

"""
Contains various functions for fixing spice files.
All fixup functions are writen as generators that take
a generator. Thus many fixups can be chained together.

The read function acts as the first generator and the write function
is the final collector that eats a generator.

Example:
  write('output.MOD', 
     name_has_slash(
         replace_string('old', 'new', 
             read('input.MOD'))))
"""

import re
import os

def read(filename):
    """Open a file and yield its lines"""
    f = open(str(filename), 'r')
    for line in f:
        yield line


def write(filename, gen):
    """Write all lines from the generator into a file"""
    f = open(str(filename), 'w')
    for line in gen:
        f.write(line)


def trailing_newline(gen):
    """
    add a headline with asterisk if missing
    add trailing newline if missing
    """
    try:
        first_line = gen.next()
        if first_line[0] != '*':
            yield '*' + os.linesep
        yield first_line
        buf1 = gen.next()
    except StopIteration:
        raise ValueError, 'Modelfile less than 2 lines'
    while True:
        try:
            buf2 = gen.next()
            yield buf1
            buf1 = buf2
        except StopIteration:
            #buf1 contains the file's last line
            if buf1[-1] != os.linesep:
                buf1 += os.linesep
            yield buf1
            raise StopIteration


def ascii_032(gen):
    """Removes the unprintable ASCII \032 character"""
    for line in gen:
        yield line.replace('\032', '')


def misplaced_ends(gen):
    """Removes excessive .ENDS statements"""
    SUBCKT_PAT = '^(\s*\.SUBCKT\s+)'
    ENDS_PAT = '^(\s*\.ENDS)'
    subckt_levels = 0
    for line in gen:
        if re.search(SUBCKT_PAT, line.upper()):
            subckt_levels += 1
        elif re.search(ENDS_PAT, line.upper()):
            if subckt_levels > 0:
                subckt_levels -= 1
            else:
                #excessive .ENDS detected: remove it
                line = '* Excessive .ENDS detected *' + line
        yield line



def ends_without_subcircuit(gen):
    """
    some models have a .ENDS statement even if there is no
    subcircuit definition.
    comment out the wrong .ENDS statement
    """
    in_subckt = False
    for line in gen:
        if line[0] != '*':  #skip comment lines
            if re.match('\.subckt', line.lower()):
                in_subckt = True
            if re.match('\.ends',line.lower()):
                if not in_subckt:
                    line = '* WRONG .ENDS BUGFIX: ' + line
                in_subckt = False
        yield line

 
def name_has_slash(gen):
    """removes a slash in the subcircuit's name, if present"""
    SUBCKT_PAT = '^(\s*\.SUBCKT\s+)(\w+)/NS'
    for line in gen:
        match = re.search(SUBCKT_PAT, line)
        if match:
            old_name = match.group(2)
            name = old_name.split('/')[0]
            yield re.sub(SUBCKT_PAT, match.group(1) + name, line)
        else:
            yield line

def replace_string(query, repl, gen):
    """
    Replaces all occurences of query with repl
    query may NOT include a newline
    """
    for line in gen:
        line = line.replace(query, repl)
        yield line

def bzx_pin_renumber(gen):
    """
    Some NXP diodes come in 3 pin packages, with 1 NC pin.
    Most of the models model a 2-pin part, but some model 3-pin parts
    Change the 3-pin models into 2-pin models
    """
    SUBCKT_PAT = '^(\s*\.SUBCKT\s+\w+)( \w+ \w+ \w+)(.*)$'
    DIODE_PAT = '^(\s*\w+\s+)(\w+\s+\w+)(\s*.*)$'
    threepins = False
    for line in gen:
        smatch = re.search(SUBCKT_PAT, line)
        if smatch:
            line = smatch.groups()[0] + ' 1 2' + smatch.groups()[2] + os.linesep
            threepins = True
        if threepins:
            dmatch = re.search(DIODE_PAT, line)
            if dmatch:
                line = dmatch.groups()[0] + '2 1 ' + dmatch.groups()[2] + os.linesep
        yield line
        
def rename_RES_and_CAP(gen):
    """
    Some National files include '.MODEL .* RES' or '.MODEL .* CAP'
    models.  But ngspice only recongizes 'R' and 'C', not 'RES' and 'CAP'
    """
    RES_PAT = '^(\s*\.MODEL\s+\w+\s+)RES(.*$)'   
    CAP_PAT = '^(\s*\.MODEL\s+\w+\s+)CAP(.*$)'   
    for line in gen:
        rmatch = re.match(RES_PAT, line, re.I)
        if rmatch:
            line = rmatch.groups()[0] + 'R' + rmatch.groups()[1] + os.linesep
        cmatch = re.match(CAP_PAT, line, re.I)
        if cmatch:
            line = cmatch.groups()[0] + 'C' + cmatch.groups()[1] + os.linesep
        yield line

def comma_lambda(gen):
    """
    For some unknown reason, ngspice doesn't like to see a comma before a
    lambda parameter in NMOS and PMOS models
    """
    PAT="(^\s*\.MODEL.*),LAMBDA=(.*$)"
    for line in gen:
        match = re.match(PAT, line, re.I)
        if match:
            line = match.groups()[0] + ' LAMBDA=' + match.groups()[1] + \
                    os.linesep
        yield line

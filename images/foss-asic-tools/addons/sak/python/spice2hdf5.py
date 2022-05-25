#!/usr/bin/python

#     Copyright (C) 2007-2008 Werner Hoch
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
# rb@ef  2017-03-14  update to tables API in py2.7, updates for py3.5

import sys, os.path, getopt
import numpy
import tables

# TODO: fix below. Use no such abs paths.
import spice_read

VERSION="0.0.2"
AUTHOR='Werner Hoch <werner.ho@gmx.de>'

def insert_spiceplot(plot, outfile="out.hdf5", path="/", name="plot",
                     filemode="a", overwrite=True, format='table'):
    ## open the hdf5-file
    h5file = tables.open_file(outfile, mode=filemode, title = "ngspice plots")

    ## create the path group
    path_toks = path[1:].split("/")
    last_path = "/"
    for i in range(len(path_toks)):
        test_path = "/" + "/".join(path_toks[:i+1])
        if test_path not in h5file:
            h5file.create_group(last_path, path_toks[i])
        last_path = test_path

    ## check if the path / table is already there
    if path + "/" +  name in h5file:
        if overwrite:
            h5file.remove_node(path, name, recursive=True)
            h5file.flush()
        else:
            print("Error: path already exists: [%s, %s]" %(path,name))
            return

    scale = plot.get_scalevector()
    data = plot.get_datavectors()

    if format == 'table':
        ## create the row description
        d_cols = {scale.name : tables.Float64Col(pos=0)}
        for i,v in enumerate(data):
            if v.get_data().dtype == numpy.float64:
                d_cols[v.name] = tables.Float64Col(pos=i+1)
            elif v.get_data().dtype == numpy.complex128:
                d_cols[v.name] = tables.ComplexCol(pos=i+1, itemsize=16)
            else:
                print("vector type " , v.get_data().dtype , "not supported yet")
                return
                
        ## create a table and add all data
        table = h5file.create_table(path, name, d_cols)
        row = table.row
        for i,s in enumerate(scale.get_data()):
            row[scale.name] = s
            for d in data:
                row[d.name] = d.get_data()[i]
            row.append()

    else: # format == vectors
        ## add all data vectors as Arrays, remove it's
        node = h5file.create_group(path, name)
        h5file.create_array(node, scale.name, scale.get_data())
        for d in data:
            if path + "/" + name + "/" + d.name in h5file:
                print("Error: data name is not uniq: [%s]" %(d.name))
                return
            h5file.create_array(node, d.name, d.get_data())
    
    h5file.flush()
    h5file.close()


def usage():
    print("spice2hdf5 version " + VERSION + "   (C) " + AUTHOR)
    print("usage: " +  sys.argv[0] + """ [options], spicefile, [spicefile2, ..]
  -h --help: print help information
  -v --verbose: print debug messages to stdout
  -o --outfile: specify the hdf5 output filename (default: out.hdf5)
  -p --pathprefix: location to store the spice data
  -f --format: whether to store the data as single vectors or table
               (default: table)""")
    


#################### MAIN

## default options and options dictionary
options = dict(verbose=False,
               format="table",
               outfile="out.hdf5",
               pathprefix="/spiceplot")

FORMAT_OPTIONS = ['table', 'vectors']

## getopt parsing
try:
    opts, args = getopt.getopt(sys.argv[1:], "hvo:p:f:",
                               ["help", "verbose","outfile=", "pathprefix=",
                                "format="])
except getopt.GetoptError as err:
    print(str(err))
    usage()
    sys.exit(2)

if len(args) == 0:
    usage()
    sys.exit(2)

## examine the parsed output
for k,v  in opts:
    if k in ('-h','--help'):
        usage()
        sys.exit(0)
    elif k in ('-v', '--verbose'):
        options['verbose'] = True
    elif k in ('-o', '--outfile'):
        options['outfile'] = v
    elif k in ('-p', '--pathprefix'):
        options['pathprefix'] = v
    elif k in ('-f', '--format'):
        if v not in FORMAT_OPTIONS:
            usage()
            sys.exit(2)
        options['format'] = v

## now execute the commands
args.sort()
for infile in args:
    filename = os.path.basename(infile)
    plots = spice_read.spice_read(infile).get_plots()
    path = options['pathprefix']
    if len(args) > 1:
        ## need to add the filename as path
        path = path + '/' + filename

    if len(plots) > 1:
        ## need to add a plot number to the path
        for i, p in enumerate(plots):
            insert_spiceplot(p, path=path, name="plot_%i"%i,
                             outfile=options['outfile'], format=options['format'])
    else:
        toks = path.split('/')
        if len(toks) == 2:
            path = '/'
        else:
            path = '/'.join(toks[:-1])
        name = toks[-1]
        insert_spiceplot(plots[0], path=path, name=name,
                         outfile=options['outfile'], format=options['format'])
        
    

#!/usr/bin/python
# 
# Copyright (c) 2017, efabless Corporation.
# All rights reserved.
#
# rb@ef  2017-03-16  author

# from __future__ import print_function
import sys
import os
import glob
import getopt
from pathlib import PurePath

# to avoid needing an X-DISPLAY
import matplotlib
matplotlib.use('Agg')

from pylab import *
import spice_read

def perr(msg):
    print( msg, file=sys.stderr)
    sys.stderr.flush()

def usage(msg = None):
    if msg: perr(msg)

    stylesAll = style.available
    print( "usage: " + sys.argv[0] + """  <options...>  [ <rawFile> ... ]
    Make a plot file (.png image) superimposing same signal(s) from multiple raw files.

    options:

    -s <sigName>  : names of signals to plot. Use again for more signals. If no -s, all signals plot.
    -g <wildPath> : match wildcarded raw-file paths. Can use again. Protect special chars from shell with quotes.
    -A <wildPath> : intersect all (-g or cmd-line) raw-file paths with this pattern. Can use again. Protect special chars from shell with quotes.
           note: one or more -g ... plus plain raw-files at end of command line accumulate, i.e. like ORing sets together,
           but adding one or more -A ... will cut-down (filter) by these patterns, i.e. like ANDing sets together,
           for example: -g "a/b/*.raw" -A "VB:1.5_" -A "temp:125_" selects files having BOTH those VB: and temp: patterns, but IN ANY ORDER.
    -o <outfile>  : name the output file. Default plot.png. Default extension is .png. If includes extension
                    this overrides a style-based format like:   savefig.format : pdf
    -v            : verbose. Repeat for even more verbose.

    -l               : Disable the legend. By default signals from 1st raw-file get a legend.
    -L               : Disable the grid. By default grid is shown.
    -T <titleString> : default none
    -X <xAxisLabel>  : default none. Note the scale is always fixed from 1st raw-file.
    -Y <yAxisLabel>  : default none
    --xscale="<scaleType>" : x-axis scale type, default linear, other values: log, symlog, logit
    --yscale="<scaleType>" : y-axis scale type, default linear, other values: log, symlog, logit

    -S <style>       : Apply matplotlib style-name (or style file-path). Use again as needed.
           available: """ + ','.join(stylesAll) + """ 
    -W <xAxisRange>  : default auto. Must be a string of one or two floats around a comma: 0,3e-3  or ,3e-3
    -H <yAxisRange>  : default auto. Must be a string of one or two floats around a comma: 2.4,3.6 or 2.4,
           Axis range can be one-ended as in: -W ".003," (max-x is auto) or -H ",2.5"  (min-y is auto)

    -G   Disable all explicit deallocates: full auto garbage-collection memory management.
    -P   Invoke tight_layout mode (less Padding: reduced spacing/margin around edges of plot).
    -D   Dimensions: x,y[,dpi] where dpi is optional, x,y widths are inches. e.g. 8.5,100  or 8.5,100,300
           To specify just dpi use: ,,dpi  e.g ,,300
           Default is like 8,6,100 (800x600 pixels at 100 dpi)

  Raw files to plot may be specified both as ordinary trailing args (after all options),
  as thru the -g. (Protect the -g argument from a shell-expansion with quotes).
  Beware of repeating the same rawfile thru multiple ways of specifying it (no auto-check for dups).

  Big example explained, two versions that are identical:
    rawn-plot1 -P -H ',2.5' -W '0.003295,' -v -v -D 8,4,300 -o /tmp/plot216.pdf -l -s 'v(vbgp)' `echo ~/design/myBandGap/startup2/layd/*/*.raw`
    rawn-plot1 -P -H ',2.5' -W '0.003295,' -v -v -D 8,4,300 -o /tmp/plot216.pdf -l -s 'v(vbgp)' -g '~/design/myBandGap/startup2/layd/*/*.raw'

    Less padding, clip max-y at 2.5, clip min-x at .003295, very verbose, size 8x4 inches at 300 dpi,
    output to /tmp/plot216.pdf, no legend, plot just one signal v(vbgp),
    process all raw-files matching wildcarded path: ~/design/myBandGap/startup2/layd/*/*.raw

""" )

def main(argv):

    err = 0
    warn = 0
    styles = []
    outFile = "plot"   # no extension, MPL defaults to png. But user's style can change format (i.e. to pdf)
    signals = []
    raws = []
    globs = []
    globsAnd = []
    verbose = 0
    doLegend = True
    xLabel = ""
    yLabel = ""
    pTitle = ""
    doTight = False
    doDel = True
    dim = None
    dimXY = None
    dpi = None
    doGrid = True
    xAxisR = None
    yAxisR = None
    xScale = None  # None means leave at built-in default: "linear".
    yScale = None
    
    if not argv[1:]:
        usage()
        sys.exit(0)

    try:
        opts, args = getopt.getopt(argv[1:], "GPhvlLD:g:A:s:o:T:X:Y:S:W:H:", ['xscale=', 'yscale='])
    except getopt.GetoptError as err:
        usage( str(err))
        sys.exit(1)

    for k,v  in opts:
        if k in ('-h'):
            usage()
            sys.exit(0)
        elif k in ('-v'):
            verbose += 1
        elif k in ('-P'):
            doTight = True
        elif k in ('-G'):
            doDel = False
        elif k in ('-l'):
            doLegend = False
        elif k in ('-L'):
            doGrid = False
        elif k in ('-o'):
            outFile = v
        elif k in ('-T'):
            pTitle = v
        elif k in ('-W'):
            xAxisR = v
        elif k in ('-H'):
            yAxisR = v
        elif k in ('-X'):
            xLabel = v
        elif k in ('-Y'):
            yLabel = v
        elif k in ('-D'):
            dim = v
        elif k in ('-s'):
            signals += [ v ]
        elif k in ('-S'):
            styles += [ v ]
        elif k in ('-g'):
            globs += [ v ]
        elif k in ('--xscale'):
            xScale = v
        elif k in ('--yscale'):
            yScale = v
        elif k in ('-A'):
            globsAnd += [ v ]

    if not dim is None:
        dims = dim.split(",")
        diml = len(dims)
        if diml == 3:
            dpi = dims[2]
            dpii = int(dpi)
            if verbose: print( "got dpi: %d" % dpii )
        if diml >= 2 and dims[0] and dims[1]:
            dimXY = [float(x) for x in dims[0:2]]
            if verbose: print( "got dimXY: %g by %g" % (dimXY[0], dimXY[1]))

    if not xAxisR is None:
        dims = xAxisR.split(",")
        diml = len(dims)
        # parse as floats
        xAxisR = [x and float(x) for x in dims]

    if not yAxisR is None:
        dims = yAxisR.split(",")
        diml = len(dims)
        # parse as floats
        yAxisR = [x and float(x) for x in dims]

    # expand glob-style options
    for g in globs:
        expand = glob.glob( os.path.expanduser( g ))
        if expand:
            raws += expand
            if verbose:
                print( "%d : #matches of glob: %s" % (len(expand), g))
            if verbose > 1:
                print( "  matches:" + ' '.join(expand))
        else:
            warn += 1
            print( "WARNING: no match for -g option: %s" % g )

    # add remaining cmd-line arguments as raw-files (no glob expansion)
    raws += args

    # Subject all raws so far (union of -g's and plain cmd-line paths) to filtering(ANDing) by one or more '-A <pattern>' options.
    # Also prune repeats: the options/cmd-line may yield repeats of same raw file thru redundant/overlapping patterns...
    filtered = []
    once = {}
    for r in raws:
        if r in once: continue
        once[r] = 1

        for g in globsAnd:
            if not PurePath(r).match(g): break
        # ! this is for ... else (not if ... else). A loop-break will by-pass the loop-else clause.
        else:
            filtered += [ r ]

    raws = filtered
    if not raws:
        # was usage(...), but usage is too long and this error too frequent...
        err += 1
        perr( "ERROR: no raw files specified (or found/yielded via pattern matching), use -h for usage" )
        sys.exit(err)

    if verbose > 1:
        print( "final raws:" + ' '.join(raws))

    # if explicit signals given, make them lowercase for comparison to raw file signals
    if signals: signals = [x.lower() for x in signals]

    scale = None
    labelled = {}

    nbrRaw = 0
    nbrSig = 0

    # do style.use(). We do them separately (instead of an array) due to concern of survivability
    # if some of them fail, still want all that work to be applied, and continue processing.
    for sty in styles:
        try:
            style.use( sty )
        except:
            err += 1
            perr( "exception on style.use of %s" % sty )

    if not dimXY is None:
        rcParams[ "figure.figsize" ] = dimXY
        if verbose > 1: print( "set figure.figsize" )
    
    if not dpi is None:
        rcParams[ "savefig.dpi" ] = dpi
        if verbose > 1: print( "set savefig.dpi" )

    fig = figure()
    # if not dpi is None:
    # in python3, these do nothing (1st worked in python2.7)?
        # fig.set_dpi(dpi)
        # gcf().set_dpi(dpi)
        # if verbose: print( "set dpi" )
        # if verbose: print( "get dpi: %d" % (gcf().get_dpi()))
    
    for raw in raws:
        # read the raw file
        rplots = spice_read.spice_read(raw).get_plots()
        if not rplots: continue
        nbrRaw += 1

        rplot = rplots[0]
        
        # set scale once, from 1st raw file. Assuming scales are all the same.
        # TODO: better to know the min/max extent of scale from all raw files.
        # And plot all sigs correctly against the (extended) overall scale.
        first = (scale is None)
        # if first:
        scale = rplot.get_scalevector().get_data()

        for rsig in rplot.get_datavectors():
            rsigl = rsig.name.lower()
            if not signals or (rsigl in signals):
                # want one-label per unique signal name; not dups by every raw file.
                # This is not very useful/helpful: In practice 1st raw file's
                # signals all are labelled, none of the rest. 
                label = None
                if rsigl not in labelled:
                    label = rsig.name
                    labelled[rsigl] = True
                plot(scale, rsig.get_data(), label=label)
                nbrSig += 1
            if doDel: del rsig

        # clean 2nd and onward raw files from memory. Can't clean 1st: need its scale.
        if not first and doDel: del rplots

    if not labelled:
        warn += 1
        perr( "WARNING: no signals plotted" )

    # TODO: add options for uniquify legend names per rawfile-name, ...
    if pTitle: title( pTitle )
    if xLabel: xlabel( xLabel )
    if yLabel: ylabel( yLabel )

    if xAxisR:
        if xAxisR[0]: xlim( left=xAxisR[0] )
        if xAxisR[1]: xlim( right=xAxisR[1] )
        # xlim(xAxisR)
    if yAxisR:
        if yAxisR[0]: ylim( bottom=yAxisR[0] )
        if yAxisR[1]: ylim( top=yAxisR[1] )
        # ylim(yAxisR)

    # support selection of any values: “linear”, “log”, “symlog”, “logit”
    # TODO: also control over nonposx='clip' and other options?
    # If user doesn't specify, we leave default (linear) as is.
    # But if user explicitly specifies linear we explicitly set it.
    if xScale == 'log':
        gca().set_xscale(xScale, nonposx='clip')
    elif xScale == 'logit':
        gca().set_xscale(xScale, nonpos='clip')
    elif xScale:
        gca().set_xscale(xScale)
    if yScale == 'log':
        gca().set_yscale(yScale, nonposy='clip')
    elif yScale == 'logit':
        gca().set_yscale(yScale, nonpos='clip')
    elif yScale:
        gca().set_yscale(yScale)

    if doTight: fig.tight_layout()
    if doGrid:
        grid()
    elif verbose > 1: print( "disabled grid" )

    if doLegend: legend()

    # python3 set_dpi fails: so pass it here (may be None, i.e. use default of 100):
    # savefig(outFile, dpi=dpi)
    savefig(outFile)
    print( "wrote %s" % outFile )
    close(fig)

    if verbose:
        print( "%d: number of raw files" % nbrRaw )
        print( "%d: number of signals plotted" % nbrSig )

    print( "%d: errors,  %d: warnings" % (err, warn))
    sys.exit(err)

if __name__ != "__main__":
    usage()
    sys.exit(1)

if __name__ == "__main__":
    main(sys.argv)

#!/usr/bin/python2.7
# vim: ts=4 : et : sw=4 :

import numpy
from spicelibconf import *


if PLOTTER == 'gnuplot':
    import Gnuplot
    Gnuplot.GnuplotOpts.default_term = "png"
else:
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot



class gnuplot_subplot(object):
    """structure for a single subplot for gnuplot"""
    def __init__(self):
        self.data = []
        self.ylabel = ''
        self.xlabel = ''
        self.logscale = ''

class gnuplot_wrapper(object):
    """
    A wrapper for gnuplot that behaves like matplotlib.pyplot.
    It is used to switch between gnuplot and matplotlib.

    Note: Create a new wrapper instance for each plot.
    """
    def __init__(self):
        self.g = Gnuplot.Gnuplot()
        self.g('set data style line')
        self.g('set terminal png')
        self.g('set key left top')
        self.subplots = [ gnuplot_subplot() ]
        self.current_subplot = self.subplots[0]
        self.layout = (1,1)

    def subplot(self, x, y, i):
        while len(self.subplots) < x*y:
            self.subplots.append(gnuplot_subplot())
        self.layout = (x,y)
        self.current_subplot = self.subplots[i-1]

    def plot(self,x,y=None,label=None):
        if y == None:
            x, y = range(len(x)), x
        self.current_subplot.data.append(Gnuplot.Data(x, y, title=label))

    def semilogx(self,x,y,label=None):
        self.current_subplot.logscale = 'x'
        self.plot(x,y,label)

    def semilogy(self,x,y,label=None):
        self.current_subplot.logscale = 'y'
        self.plot(x,y,label)

    def loglog(self,x,y,label=None):
        self.current_subplot.logscale = 'xy'
        self.plot(x,y,label)

    def xlabel(self, label):
        self.current_subplot.xlabel = label
        
    def ylabel(self, label):
        self.current_subplot.ylabel = label

    def legend(self, *args, **kwargs):
        pass

    def grid(self, loc=None):
        self.g('set grid')
    
    def savefig(self, filename, **kwargs):
        self.g('set output "%s"' % filename)
        if len(self.subplots) > 1:
            rows, cols = self.layout
            self.g('set multiplot layout %d, %d' % (rows, cols))
        for sub in self.subplots:
            self.g('unset logscale')
            if sub.logscale != '':
                self.g('set logscale %s' % sub.logscale)
            self.g.xlabel(sub.xlabel)
            self.g.ylabel(sub.ylabel)
            self.g.plot(*sub.data)

    def close(self):
        """
        clean out all subplots, thus the instance can create a new plot.
        Note:
        If I don't clear the plots, gnuplots writes the data of
        two plots into one.
        If I create an extra plotting instance, then gnuplot doesn't return.
        """
        self.subplots = [ gnuplot_subplot() ]
        self.current_subplot = self.subplots[0]
        self.layout = (1,1)


def plotter():
    if PLOTTER == 'gnuplot':
        return gnuplot_wrapper()
    else:
        return matplotlib.pyplot


def test_gnuplot_wrapper():
    """ Test function for the matplotlib gnuplot wrapper """
    pl = gnuplot_wrapper()
    pl.plot([1,2,3], label='test123')
    pl.savefig('123.png')
    pl.close()

    pl = gnuplot_wrapper()

    pl.subplot(2,2,1)
    pl.plot([1,2,3,7],[3,2,4,3])

    pl.subplot(2,2,2)
    pl.semilogx([1,2,34],[0.1,2,3], label='semilogx')
    pl.xlabel('xxx1')

    pl.subplot(2,2,3)
    pl.semilogy([1,2,34],[0.1,2,3], label='semilogy')
    pl.semilogy([2,3,4],[0.9,5,2], label='semilogy2')
    pl.ylabel('yyy1')

    pl.subplot(2,2,4)
    pl.loglog([1,10,100], [2, 4, 8], label='loglog')

    pl.grid()
    pl.savefig('2x2_test.png')
    pl.close()


if __name__ == '__main__':
    import Gnuplot
    test_gnuplot_wrapper()
    

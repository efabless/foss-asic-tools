#!/usr/bin/python

PLOTTER='matplotlib'
#PLOTTER='gnuplot'

COLORS = {"broken": "#FF3F3F",
          "good": "#7FFF7F",
          "---": "#CFCFCF",
          "test": "#FFFF7F",
          "missing1": "#FFFF7F",
          "missing2": "#FFFF7F",
          "failed": "#FF3F3F",
          "succeeded": "#7FFF7F",
          "NIY": "#CFCFCF",
          "undefined": "#CFCFCF",
          "default": "#FFFFFF",
          True:"#FFFFFF",
          False:"#FF3F3F"}

# The format of simulators is a dict of dictionaries.
# The keys are the simulator identification's name. This is a unique
# name that is displayed as headline in the index table.
# The simulator references the simulator type required by the parttest.
# The command tells how to invoke it and the spice file syntax
# The values are either full paths or just the executable that is in
# the PATH.
# The command can contain spaces to facilitate the use of wrapper scripts
# e.g. '/usr/local/bin/spice-wrapper gnucap'
# The folder value defines the storage of the result files
# e.g. [PARTNAME]/[folder]/index.html
SIMULATORS = {
    'ngspice_25': {'simulator':'ngspice',
                   'command': 'ngspice',
                   'options': '-r X -b',  ## -r X suppresses the "no plot" error
                   'folder': 'ng25'},
    'gnucap_0.35': {'simulator':'gnucap',
                    'command': '/usr/bin/gnucap',
                    'options': '-b',
                    'folder': 'gc0.35'}
    }

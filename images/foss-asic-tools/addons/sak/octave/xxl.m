#! /usr/bin/octave -qf

filename = argv()
[data,colnames,s]=spice_readfile(filename);
plot (data(:,1), data)
pause

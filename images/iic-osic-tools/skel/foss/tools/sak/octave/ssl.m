#!/usr/bin/octave -qf

## tests for the spice_readfile function


#################### helper function ####################
function plot_matrix(matrix, colnames, headline)
  maxrow=rows(colnames);
  xlabel(colnames{1})
  grid
  title(headline)
  rownr=2;
  s=sprintf("plot(matrix(:,1),matrix(:,%d),\";%s;\"",rownr,colnames{rownr,:});
  while (rownr < maxrow)
    rownr=rownr+1;
    s=sprintf("%s,matrix(:,1),matrix(:,%d),\";%s;\"",s,rownr,colnames{rownr,:});
  endwhile
  s=sprintf("%s);",s);
  eval(s);
endfunction

#################### MAIN ####################

arg_list = argv()

filename = argv()
# load("-ascii",filename);

## transient analyses
[data,colnames,s]=spice_readfile(filename);
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);
pause;

subplot (3, 1, 1)
plot (data(:,1), data(:,2));
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);

subplot (3, 1, 2)
plot (data(:,1), data(:,3));

subplot (3, 1, 3)
plot (data(:,1), data(:,4));
pause;

plot (data(:,1), data)


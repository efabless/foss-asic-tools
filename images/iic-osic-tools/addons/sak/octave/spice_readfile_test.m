#!/usr/bin/octave -qf

## tests for the spice_readfile function


#################### helper function ####################
function plot_matrix(matrix, colnames, headline)
  maxrow=rows(colnames);
  xlabel(colnames{1})
  grid
  title(headline)
  rownr=2;
  s=sprintf("plot(matrix(:,1),matrix(:,%d),\";%s;\"",rownr,colnames(rownr,:));
  while (rownr < maxrow)
    rownr=rownr+1;
    s=sprintf("%s,matrix(:,1),matrix(:,%d),\";%s;\"",
	      s,rownr,colnames(rownr,:));
  endwhile
  s=sprintf("%s);",s);
  eval(s);
endfunction

#################### MAIN ####################

## transient analyses
[data,colnames,s]=spice_readfile("tran_ascii.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);
pause;

[data,colnames,s]=spice_readfile("tran_binary.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);
pause;

## ac analyses
[data,colnames,s]=spice_readfile("ac_ascii.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(abs(data),colnames,[s.plotname,":  ",s.title]);
pause;
plot_matrix([real(data(:,1)),arg(data(:,2:columns(data)))], \
	    colnames,[s.plotname,":  ",s.title]);
pause;

[data,colnames,s]=spice_readfile("ac_binary.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(abs(data),colnames,[s.plotname,":  ",s.title]);
pause;
plot_matrix([real(data(:,1)),arg(data(:,2:columns(data)))], \
	    colnames,[s.plotname,":  ",s.title]);
pause;


## parametric dc analyses
[data,colnames,s]=spice_readfile("dc_ascii.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);
pause;

[data,colnames,s]=spice_readfile("dc_binary.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);
pause;


## double parametric dc analyses
[data,colnames,s]=spice_readfile("dc_dc_ascii.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);
pause;

[data,colnames,s]=spice_readfile("dc_dc_binary.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);
pause;


## noise analyses
[data,colnames,s]=spice_readfile("noise_ascii.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);
pause;

[data,colnames,s]=spice_readfile("noise_binary.raw");
s
colnames
[rows,cols]=size(data);
printf("datamatrix size: %d rows, %d columns\n",rows,cols);
plot_matrix(data,colnames,[s.plotname,":  ",s.title]);
pause;

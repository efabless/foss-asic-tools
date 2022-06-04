#! /usr/bin/octave -qf

filename = argv()
[A,B] = textread('out.txt', '%s %f' ,'delimiter' , ' ' )
m = mean(B)
s = std(B)
m + 3*s
m - 3*s
cpkh = abs((1.25 - m)/(3*s))
cpkl = abs((m - 1.21)/(3*s))
cpk = min(cpkh, cpkl)
plot(B)
hist(B,1000)
pause


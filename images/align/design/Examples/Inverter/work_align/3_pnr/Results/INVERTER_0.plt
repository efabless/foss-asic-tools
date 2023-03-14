#Use this file as a script for gnuplot
#(See http://www.gnuplot.info/ for details)

set title" #Blocks= 2, #Terminals= 2, #Nets= 2,Area=6.4727e+08, HPWL= 48280 "

set nokey
#   Uncomment these two lines starting with "set"
#   to save an EPS file for inclusion into a latex document
# set terminal postscript eps color solid 20
# set output "result.eps"

#   Uncomment these two lines starting with "set"
#   to save a PS file for printing
# set terminal postscript portrait color solid 20
# set output "result.ps"


set xrange [-50:24130]

set yrange [-50:26930]

set label "X_XM1" at 18060 , 13440 center 

set label "D" at 17200 , 6720


set label "G" at 18060 , 15120


set label "S" at 18920 , 13440


set label "X_XM2" at 6020 , 13440 center 

set label "D" at 6880 , 6720


set label "G" at 6020 , 15120


set label "S" at 5160 , 13440


set label "Y" at 17200 , 0 center                

set label "A" at 24080 , 15120 center                

plot[:][:] '-' with lines linestyle 3, '-' with lines linestyle 7, '-' with lines linestyle 1, '-' with lines linestyle 0

# block X_XM1 select 0 bsize 4
	12040	0
	12040	26880
	24080	26880
	24080	0
	12040	0

# block X_XM2 select 0 bsize 4
	0	0
	0	26880
	12040	26880
	12040	0
	0	0


EOF
	16920	520
	16920	12920
	17480	12920
	17480	520
	16920	520

	17780	8920
	17780	21320
	18340	21320
	18340	8920
	17780	8920

	18640	1360
	18640	25520
	19200	25520
	19200	1360
	18640	1360

	7160	520
	7160	12920
	6600	12920
	6600	520
	7160	520

	6300	8920
	6300	21320
	5740	21320
	5740	8920
	6300	8920

	5440	1360
	5440	25520
	4880	25520
	4880	1360
	5440	1360


EOF

	17200	0
	17200	0
	17200	0
	17200	0
	17200	0

	24080	15120
	24080	15120
	24080	15120
	24080	15120
	24080	15120

EOF

#Net: Y
	17200	6720
	6880	6720
	17200	6720

	17200	6720
	17200	0
	17200	6720


#Net: A
	18060	15120
	6020	15120
	18060	15120

	18060	15120
	24080	15120
	18060	15120


EOF

pause -1 'Press any key'
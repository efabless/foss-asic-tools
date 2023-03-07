#Use this file as a script for gnuplot
#(See http://www.gnuplot.info/ for details)

set title" #Blocks= 2, #Terminals= 4, #Nets= 4,Area=1.56038e+08, HPWL= 52000 "

set nokey
#   Uncomment these two lines starting with "set"
#   to save an EPS file for inclusion into a latex document
# set terminal postscript eps color solid 20
# set output "result.eps"

#   Uncomment these two lines starting with "set"
#   to save a PS file for printing
# set terminal postscript portrait color solid 20
# set output "result.ps"


set xrange [-50:5210]

set yrange [-50:30290]

set label "X_M0" at 2580 , 7560 center 

set label "D" at 3440 , 14280


set label "G" at 3440 , 5880


set label "S" at 1720 , 7560


set label "X_M1" at 2580 , 22680 center 

set label "D" at 3440 , 15960


set label "G" at 3440 , 24360


set label "S" at 1720 , 22680


set label "ZN" at 5160 , 14280 center                

set label "I" at 5160 , 5880 center                

set label "SN" at 0 , 7560 center                

set label "SP" at 0 , 22680 center                

plot[:][:] '-' with lines linestyle 3, '-' with lines linestyle 7, '-' with lines linestyle 1, '-' with lines linestyle 0

# block X_M0 select 0 bsize 4
	0	0
	0	15120
	5160	15120
	5160	0
	0	0

# block X_M1 select 0 bsize 4
	0	15120
	0	30240
	5160	30240
	5160	15120
	0	15120


EOF
	4640	14560
	4640	14000
	2240	14000
	2240	14560
	4640	14560

	4640	6160
	4640	5600
	2240	5600
	2240	6160
	4640	6160

	2000	13760
	2000	1360
	1440	1360
	1440	13760
	2000	13760

	4640	15680
	4640	16240
	2240	16240
	2240	15680
	4640	15680

	4640	24080
	4640	24640
	2240	24640
	2240	24080
	4640	24080

	2000	16480
	2000	28880
	1440	28880
	1440	16480
	2000	16480


EOF

	5160	14280
	5160	14280
	5160	14280
	5160	14280
	5160	14280

	5160	5880
	5160	5880
	5160	5880
	5160	5880
	5160	5880

	0	7560
	0	7560
	0	7560
	0	7560
	0	7560

	0	22680
	0	22680
	0	22680
	0	22680
	0	22680

EOF

#Net: ZN
	3440	14280
	3440	15960
	3440	14280

	3440	14280
	5160	14280
	3440	14280


#Net: I
	3440	5880
	3440	24360
	3440	5880

	3440	5880
	5160	5880
	3440	5880


#Net: SN
	1720	7560
	0	7560
	1720	7560


#Net: SP
	1720	22680
	0	22680
	1720	22680


EOF

pause -1 'Press any key'
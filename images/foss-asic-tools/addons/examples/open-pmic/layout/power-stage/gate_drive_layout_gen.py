from math import floor

PITCH = 0.79

def via_1_2(x, y, fout):
	cmd_str = "box %gum %gum %gum %gum\n" % (x, y, x, y)
	fout.write(cmd_str)
	#expand to via width 
	cmd_str = "box grow center %gum\n" % (0.26/2)
	fout.write(cmd_str)
	cmd_str = "paint m2contact\n"
	fout.write(cmd_str)

	#m1 vertical extention 
	cmd_str = "box grow n %gum\n" % (0.03)
	fout.write(cmd_str)

	cmd_str = "box grow s %gum\n" % (0.03)
	fout.write(cmd_str)


	cmd_str = "paint metal1\n"
	fout.write(cmd_str)

	#m2 vertical extention 
	cmd_str = "box shrink n %gum\n" % (0.03)
	fout.write(cmd_str)

	cmd_str = "box shrink s %gum\n" % (0.03)
	fout.write(cmd_str)

	#m1 vertical extention 
	cmd_str = "box grow e %gum\n" % (0.03)
	fout.write(cmd_str)

	cmd_str = "box grow w %gum\n" % (0.03)
	fout.write(cmd_str)

	cmd_str = "paint metal2\n"
	fout.write(cmd_str)

def via_locali(x, y, fout):

	#base via
	cmd_str = "box %gum %gum %gum %gum\n" % (x, y, x, y)
	fout.write(cmd_str)
	cmd_str = "box grow center %gum\n" % (0.17/2)
	fout.write(cmd_str)
	cmd_str = "paint viali\n"
	fout.write(cmd_str)

	#metal cover 
	cmd_str = "box grow center %gum\n" % (0.03)
	fout.write(cmd_str)
	cmd_str = "box grow n %gum\n" % (0.03)
	fout.write(cmd_str)
	cmd_str = "box grow s %gum\n" % (0.03)
	fout.write(cmd_str)
	cmd_str = "paint metal1\n"
	fout.write(cmd_str)



fin = open("helper_functions.tcl", "r")
fout = open("gate_drive_build.tcl", "w")
for line in fin:
	fout.write(line)


#measured distances of generated FETS
PMOS_GATE_VIA_OFFSET = 15.64/2
NMOS_GATE_VIA_OFFSET = 7.55/2
MOS_PITCH = 0.79
PMOS_DRAIN_OFFSET = 15/2
NMOS_DRAIN_OFFSET = 7/2

NUM_FINGERS = 88

MOS_CENTER_X = 0

PMOS_CENTER_Y = 15.64/2 + 2

NMOS_CENTER_Y = -7.55/2 - 2

SOURCE_EXTENTION = 1.5
DRAIN_EXTENTION = 0.25
DRAIN_EXTENTION_M2 = 1

GATE_EXTENTION = 3

DIFF_METAL_WIDTH = 0.23

M1_GATE_WIDTH = 0.23

cmd_str = "load gate_drive\n"
fout.write(cmd_str)

#place fets 
cmd_str = "place_nmos %g %g %g %g %g %g \n" % (MOS_CENTER_X, NMOS_CENTER_Y, 7, 0.5, NUM_FINGERS, 1) 
fout.write(cmd_str)
cmd_str = "place_pmos %g %g %g %g %g %g \n" % (MOS_CENTER_X, PMOS_CENTER_Y, 15, 0.5, NUM_FINGERS, 2) 
fout.write(cmd_str)

#place smaller fets 
cmd_str = "place_nmos %g %g %g %g %g %g \n" % (MOS_CENTER_X - PITCH*(NUM_FINGERS/2) - 3, NMOS_CENTER_Y + (7-2)/2, 2, 0.5, 4, 3) 
fout.write(cmd_str)
cmd_str = "place_pmos %g %g %g %g %g %g \n" % (MOS_CENTER_X - PITCH*(NUM_FINGERS/2) - 3, PMOS_CENTER_Y - (15-4)/2, 4, 0.5, 4, 4) 
fout.write(cmd_str)

#extend connections
#even fingers are source, extend up, 
#odd fingers are drain, extend down

#this works for an even number of FETs 
#source contacts
for index in range(NUM_FINGERS+1):

	drain_center_x = (index-(NUM_FINGERS/2)) * MOS_PITCH

	if (index%2 ==0): 
		#source contact, extend PMOS on top, NMOS on bottom

		x1 = drain_center_x - DIFF_METAL_WIDTH/2
		x2 = drain_center_x + DIFF_METAL_WIDTH/2
		y1 = PMOS_CENTER_Y + PMOS_DRAIN_OFFSET   
		y2 = PMOS_CENTER_Y + PMOS_DRAIN_OFFSET + SOURCE_EXTENTION

		cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
		fout.write(cmd_str) 
		cmd_str = "paint metal1\n"
		fout.write(cmd_str)

		y1 = NMOS_CENTER_Y - NMOS_DRAIN_OFFSET - SOURCE_EXTENTION
		y2 = NMOS_CENTER_Y - NMOS_DRAIN_OFFSET 

		cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
		fout.write(cmd_str) 
		cmd_str = "paint metal1\n"
		fout.write(cmd_str)

	else:
		#drain contact, extend PMOS on bottom, NMOS on top

		x1 = drain_center_x - DIFF_METAL_WIDTH/2
		x2 = drain_center_x + DIFF_METAL_WIDTH/2
		y1 = PMOS_CENTER_Y - PMOS_DRAIN_OFFSET - DRAIN_EXTENTION   
		y2 = PMOS_CENTER_Y - PMOS_DRAIN_OFFSET

		cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
		fout.write(cmd_str) 
		cmd_str = "paint metal1\n"
		fout.write(cmd_str)

		via_1_2(drain_center_x, y1, fout)

		y2 = PMOS_CENTER_Y - PMOS_DRAIN_OFFSET - DRAIN_EXTENTION
		y1 = PMOS_CENTER_Y - PMOS_DRAIN_OFFSET - DRAIN_EXTENTION - DRAIN_EXTENTION_M2

		cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
		fout.write(cmd_str) 
		cmd_str = "paint metal2\n"
		fout.write(cmd_str)



		y1 = NMOS_CENTER_Y + NMOS_DRAIN_OFFSET 
		y2 = NMOS_CENTER_Y + NMOS_DRAIN_OFFSET + DRAIN_EXTENTION

		cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
		fout.write(cmd_str) 
		cmd_str = "paint metal1\n"
		fout.write(cmd_str)

		via_1_2(drain_center_x, y2, fout)

		y1 = NMOS_CENTER_Y + NMOS_DRAIN_OFFSET + DRAIN_EXTENTION
		y2 = NMOS_CENTER_Y + NMOS_DRAIN_OFFSET + DRAIN_EXTENTION + DRAIN_EXTENTION_M2

		cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
		fout.write(cmd_str) 
		cmd_str = "paint metal2\n"
		fout.write(cmd_str)


#gate contacts
for index in range(NUM_FINGERS):

	gate_center_x = index * MOS_PITCH -(NUM_FINGERS/2-1+0.5)*MOS_PITCH

	#draw vias on PMOS top and bottom, connect across gate with M1, extend gate contact on M2 towards center
	via_locali(gate_center_x, PMOS_CENTER_Y-PMOS_GATE_VIA_OFFSET, fout)
	via_locali(gate_center_x, PMOS_CENTER_Y+PMOS_GATE_VIA_OFFSET, fout)
	via_locali(gate_center_x, NMOS_CENTER_Y-NMOS_GATE_VIA_OFFSET, fout)
	via_locali(gate_center_x, NMOS_CENTER_Y+NMOS_GATE_VIA_OFFSET, fout)

	#gate runers connecting top and bottom contact, extending down. 
	x1 = gate_center_x - M1_GATE_WIDTH/2
	x2 = gate_center_x + M1_GATE_WIDTH/2

	y1 = PMOS_CENTER_Y-PMOS_GATE_VIA_OFFSET - GATE_EXTENTION
	y2 = PMOS_CENTER_Y+PMOS_GATE_VIA_OFFSET

	cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
	fout.write(cmd_str) 
	cmd_str = "paint metal1\n"
	fout.write(cmd_str)

	y1 = NMOS_CENTER_Y-NMOS_GATE_VIA_OFFSET
	y2 = NMOS_CENTER_Y+NMOS_GATE_VIA_OFFSET + GATE_EXTENTION

	cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
	fout.write(cmd_str) 
	cmd_str = "paint metal1\n"
	fout.write(cmd_str)

#nwell
x1 = -42.5
x2 = 38
y1 = 0  
y2 = 20

cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint nwell\n"
fout.write(cmd_str)

#pwell
x1 = -42.5
x2 = 38
y1 = -12  
y2 = 0

cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint pwell\n"
fout.write(cmd_str)

#place well contacts


#left side pwell
x1 = -42
x2 = -41.5
y1 = -11.5  
y2 = -0.5
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint mvpsubdiff\n"
fout.write(cmd_str)
cmd_str = "paint metal1\n"
fout.write(cmd_str)
cmd_str = "paint locali\n"
fout.write(cmd_str)
cmd_str = "box shrink center %gum\n" % (0.12)
fout.write(cmd_str)
cmd_str = "paint mvpsubdiffcont\n"
fout.write(cmd_str)
cmd_str = "paint viali\n"
fout.write(cmd_str)

#right side pwell
x1 = 37
x2 = 37.5
y1 = -11.5  
y2 = -0.5
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint mvpsubdiff\n"
fout.write(cmd_str)
cmd_str = "paint metal1\n"
fout.write(cmd_str)
cmd_str = "paint locali\n"
fout.write(cmd_str)
cmd_str = "box shrink center %gum\n" % (0.12)
fout.write(cmd_str)
cmd_str = "paint mvpsubdiffcont\n"
fout.write(cmd_str)
cmd_str = "paint viali\n"
fout.write(cmd_str)

#top side pwell

x1 = -42
x2 = 37.5
y1 = -1  
y2 = -0.5
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint mvpsubdiff\n"
fout.write(cmd_str)
cmd_str = "paint locali\n"
fout.write(cmd_str)
cmd_str = "box shrink center %gum\n" % (0.12)
fout.write(cmd_str)
cmd_str = "paint mvpsubdiffcont\n"
fout.write(cmd_str)

#bottom side pwell
x1 = -42
x2 = 37.5
y1 = -11.5  
y2 = -11
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint mvpsubdiff\n"
fout.write(cmd_str)
cmd_str = "paint metal1\n"
fout.write(cmd_str)
cmd_str = "paint locali\n"
fout.write(cmd_str)
cmd_str = "box shrink center %gum\n" % (0.12)
fout.write(cmd_str)
cmd_str = "paint mvpsubdiffcont\n"
fout.write(cmd_str)
cmd_str = "paint viali\n"
fout.write(cmd_str)

#top size nwell
x1 = -42
x2 = 37.5
y1 = 19 
y2 = 19.5
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint mvnsubdiff\n"
fout.write(cmd_str)
cmd_str = "paint metal1\n"
fout.write(cmd_str)
cmd_str = "paint locali\n"
fout.write(cmd_str)
cmd_str = "box shrink center %gum\n" % (0.12)
fout.write(cmd_str)
cmd_str = "paint mvnsubdiffcont\n"
fout.write(cmd_str)
cmd_str = "paint viali\n"
fout.write(cmd_str)

#bottom size nwell
x1 = -42
x2 = 37.5
y1 = 0.5 
y2 = 1
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint mvnsubdiff\n"
fout.write(cmd_str)
cmd_str = "paint locali\n"
fout.write(cmd_str)
cmd_str = "box shrink center %gum\n" % (0.12)
fout.write(cmd_str)
cmd_str = "paint mvnsubdiffcont\n"
fout.write(cmd_str)

#left nwell

x1 = -42
x2 = -41.5
y1 = 0.5 
y2 = 19.5
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint mvnsubdiff\n"
fout.write(cmd_str)
cmd_str = "paint metal1\n"
fout.write(cmd_str)
cmd_str = "paint locali\n"
fout.write(cmd_str)
cmd_str = "box shrink center %gum\n" % (0.12)
fout.write(cmd_str)
cmd_str = "paint mvnsubdiffcont\n"
fout.write(cmd_str)
cmd_str = "paint viali\n"
fout.write(cmd_str)

#right nwell

x1 = 37
x2 = 37.5
y1 = 0.5 
y2 = 19.5
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint mvnsubdiff\n"
fout.write(cmd_str)
cmd_str = "paint metal1\n"
fout.write(cmd_str)
cmd_str = "paint locali\n"
fout.write(cmd_str)
cmd_str = "box shrink center %gum\n" % (0.12)
fout.write(cmd_str)
cmd_str = "paint mvnsubdiffcont\n"
fout.write(cmd_str)
cmd_str = "paint viali\n"
fout.write(cmd_str)

#power rails 
x1 = -42.5
x2 = 38
y1 = 18
y2 = 20
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint m1\n"
fout.write(cmd_str)

#power rails 
x1 = -42.5
x2 = 38
y1 = -10
y2 = -12
cmd_str = "box %gum %gum %gum %gum\n" % (x1, y1, x2, y2)
fout.write(cmd_str) 
cmd_str = "paint m1\n"
fout.write(cmd_str)

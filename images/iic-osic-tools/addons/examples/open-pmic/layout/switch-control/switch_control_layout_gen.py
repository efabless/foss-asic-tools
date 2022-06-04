


#layout notes:
# min M1 trace width for M1-M2 via: 0.26um
# min M2 trace width for Li -M2 via: 0.23um trace with 0.17um x 0.17um contact


class LogicCell:
	def __init__(self, name, width):
		self.width = width
		self.name = name



inv1 = LogicCell("sky130_fd_sc_hvl__inv_1", 1.44)
inv4 = LogicCell("sky130_fd_sc_hvl__inv_4", 3.84)
decap_8 = LogicCell("sky130_fd_sc_hvl__decap_8", 3.84)
mux2 = LogicCell("sky130_fd_sc_hvl__mux2_1", 5.28)
or2 = LogicCell("sky130_fd_sc_hvl__or2_1", 3.36)
nor2 = LogicCell("sky130_fd_sc_hvl__nor2_1", 2.4)
nand2 = LogicCell("sky130_fd_sc_hvl__nand2_1", 2.4)
and2 = LogicCell("sky130_fd_sc_hvl__and2_1", 3.36)


flipped_cells = [mux2]

fout = open("switch_control_build.tcl", "w")

cmd_str = "load switch_control\n"
fout.write(cmd_str)

vertical_pitch = 4.07
row0 = [decap_8, mux2, inv1, inv4] #timeout select
row1 = [decap_8, and2, or2, inv1, and2, nor2, nor2] #input and SR latch 
row2 = [decap_8, decap_8, decap_8, nand2, mux2] # PMOS switch control 
row3 = [decap_8, decap_8, decap_8, and2, mux2] #nmos switch control
row4 = [decap_8, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv4] #PMOS delay chain
row5 = [decap_8, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv4] #PMOS delay chain
row6 = [decap_8, mux2, or2, inv1, inv4, inv4] #pmos out
row7 = [decap_8, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv4] #NMOS delay chain
row8 = [decap_8, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv1, inv4] #NMOS delay chain
row9 = [decap_8, mux2, and2, inv1, inv4, inv4] #nmos out

ending_decap_loc = 0
rows = [row0, row1, row2, row3, row4, row5, row6, row7, row8, row9]

x_start = 0
y_start = 0

y_val = y_start
index = 0


ending_decap_loc = 0
for row in rows:
	total_width = 0
	for cell in row:
		total_width = total_width + cell.width
	if total_width > ending_decap_loc:
		ending_decap_loc = total_width

for row in rows:

	x_val = x_start
	y_val = y_val + vertical_pitch

	for cell in row:

		cmd_str = "box %gum %gum %gum %gum\n" % (x_val, y_val, x_val, y_val)
		fout.write(cmd_str)

		if (index%2 == 0): #normal orientation 

			if cell in flipped_cells:
				cmd_str = "getcell %s h child ll \n" % (cell.name)
				fout.write(cmd_str)
			else:
				cmd_str = "getcell %s child ll \n" % (cell.name)
				fout.write(cmd_str)

		else: #odd cells are vertically flipped so power stripes align 
			if cell in flipped_cells:
				cmd_str = "getcell %s 180 child ll \n" % (cell.name)
				fout.write(cmd_str)
			else:
				cmd_str = "getcell %s v child ll \n" % (cell.name)
				fout.write(cmd_str)


		x_val = x_val + cell.width


	#ending decap 
	x_val = ending_decap_loc
	cell = decap_8
	cmd_str = "box %gum %gum %gum %gum\n" % (x_val, y_val, x_val, y_val)
	fout.write(cmd_str)

	if (index%2 == 0): #normal orientation 

		if cell in flipped_cells:
			cmd_str = "getcell %s h child ll \n" % (cell.name)
			fout.write(cmd_str)
		else:
			cmd_str = "getcell %s child ll \n" % (cell.name)
			fout.write(cmd_str)

	else: #odd cells are vertically flipped so power stripes align 
		if cell in flipped_cells:
			cmd_str = "getcell %s 180 child ll \n" % (cell.name)
			fout.write(cmd_str)
		else:
			cmd_str = "getcell %s v child ll \n" % (cell.name)
			fout.write(cmd_str)


	index = index + 1


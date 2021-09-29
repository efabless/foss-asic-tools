#! /usr/bin/python

#
# Simple structured VERILOG netlist to SPICE netlist translator
#
# usage example : assuming a verilog netlist called final.v 
#                 based on a stdcells library and a memory :
#
# python verilog2spice.py -spice stdcells.cdl -spice memory.cdl -verilog final.v -output final.sp -pos_pwr VDD -neg_pwr VSS -delimiter
#
#   if pos_pwr and neg_pwr are not specified, they are by default VDD and VSS
#
#   if -delimiter is used the busses delimiter will be changed
#   from [:] in the verilog netlist to <:> in the spice netlist
#
#     distributed under GNU GPLv3
##############################################################################

import sys
import re
from datetime import datetime

spi_files = []
ver_file = ''
out_file = ''
pos_pwr = 'VDD'
neg_pwr = 'VSS'
del_on = False

for arg in range(1,len(sys.argv)) : # parse all arguments 
	if sys.argv[arg] == '-spice' :
			spi_files.append(sys.argv[arg+1])
	elif sys.argv[arg] == '-verilog' :
			if ver_file != "" :
				print ('ERROR : only one structured Verilog netlist can be specified !')
			else :
				ver_file = sys.argv[arg+1]
	elif sys.argv[arg] == '-output' :
			if out_file != "" :
				print ('ERROR : only one output Spice netlist can be specified !')
			else :
				out_file = sys.argv[arg+1]
	if sys.argv[arg] == '-pos_pwr' :
			pos_pwr = sys.argv[arg+1]
	if sys.argv[arg] == '-neg_pwr' :
			neg_pwr = sys.argv[arg+1]
	elif sys.argv[arg] == '-delimiter' :
		del_on = True
		
if len(spi_files) == 0 :
	sys.exit("Spice library netlist not specified")
if ver_file == "" :
	sys.exit("Verilog netlist not specified")
if out_file == "" :
	sys.exit("Output Spice netlist not specified")
if del_on :
	print ('The positive power supply is : ' + pos_pwr + '  The negative one : ' + neg_pwr + '  Busses are delimited by <:>')
else :
	print ('The positive power supply is : ' + pos_pwr + '  The negative one : ' + neg_pwr + '  Busses are delimited by [:]')

nb_subckt = 0  # number of cells in the spice netlist
cells = []   # list of cell of the spice netlist
cell_num = 0 #same as nb_subckt + 1
inst_on = False
subckt_on = False
spi_inc = ""

# parse the SPICE cells library file :
######################################
for spi_file in spi_files :
	spifl  = open(spi_file,'r')  # open a SPICE library file
	if spi_file.find('\\') != -1 : # remove any path from the reference SPICE netlist
		spi_file = spi_file[spi_file.rfind('\\')+1:]
	if spi_file.find('/') != -1 : # remove any path from the reference SPICE netlist
		spi_file = spi_file[spi_file.rfind('/')+1:]
	spi_inc = spi_inc + spi_file + ' '
	for line1 in spifl:
		words = line1.upper().rstrip('\r\n').strip().split()
		if len(words) > 0:
			if words[0].find('SUBCKT') == 1 :
				subckt_on = True
				nb_subckt += 1
				words.pop(0)
				cells.append(words)
			elif subckt_on and words[0] == '+' : # case of .SUBCKT defined on several lines
				cells[cell_num].extend(words)  # store each cell_name and pins in a list
			else :
				subckt_on = False
			if words[0].find('ENDS') == 1 : # end of SUBCKT
				#print (cells[cell_num])
				cell_num += 1
	spifl.close()

if nb_subckt == 0 :
	sys.exit('\nERROR : NO subckt found in the Spice netlist !\n')
else :
	print ('... end of SPICE netlist parsing : ' + str(nb_subckt) + ' cells found in the SPICE netist.\n')

# parse the VERILOG netlist :
#############################
verfl  = open(ver_file,'r')  # open VERILOG file to translate
outfl = open(out_file,'w')   # open the output SPICE netlist

nb_subckt = 0
nb_pins = 0
outfl.write('*\n*  ' +out_file + ' : SPICE netlist translated from the VERILOG netlist : ' + ver_file + '\n')
outfl.write('*'+ ' '* (len(out_file) + 5 ) + 'on the ' + str(datetime.now())+ '\n*\n')
outfl.write('*' * (len(out_file) + len(ver_file) + 60) + '\n\n')
outfl.write('.INCLUDE ' + spi_inc + '\n\n')

for line1 in verfl:
	words = line1.upper().rstrip('\r\n').strip().split()
	if len(words) > 0:
		if words[0].find('MODULE') == 0 : #first build the toplevel subckt
			subckt_name = words[1]
			subckt = '.SUBCKT ' + subckt_name + ' '
		if words[0].startswith('INPUT') or words[0].startswith('OUTPUT') or words[0].startswith('INOUT') :
			subckt_on = True
			if line1.find('[') == -1 : # pins that are not a bus
				subckt += line1[line1.upper().find(words[0])+6:].strip() + ' '
				subckt = subckt.replace(',','')
				subckt = subckt.replace(';','')
				
			else : # busses treatment
				lsb = min(int(line1[line1.find('[')+1 : line1.find(':')]) , int(line1[line1.find(':')+1 : line1.find(']')]))
				msb = max(int(line1[line1.find('[')+1 : line1.find(':')]) , int(line1[line1.find(':')+1 : line1.find(']')]))		
				words = re.split(', *', line1[line1.find(']')+1:].rstrip('\r\n').strip().replace(';',''))
				for word in words:
					for i in range(lsb,msb+1): # spread each bit of each bus
						subckt += word + '[' + str(i) + '] '

	if subckt_on and line1.find('(')>0 : # first cell detected : write the toplevel .SUBCKT
		subckt_on = False
		if del_on :  # change the busses delimiter
			subckt = subckt.replace('[','<').replace(']','>')
		outfl.write('.GLOBAL ' + pos_pwr + ' ' + neg_pwr + '\n\n' + subckt.upper() + '\n\n')

	if (not subckt_on) and (not inst_on) and re.search('\(\s*\.',line1) :
		words = line1.upper().rstrip('\r\n').strip().split()
		if words[1][0] == 'X' :  # avoid double XX at the beginning of the instance name
			instance = words[1]
		else :
			instance = 'X' + words[1]		
		subckt = words[0]
		inst_on = True
		line2 = line1[line1.find('(')+1:]
	elif (not subckt_on) and inst_on :  # store all the instance description into line2
		line2 = line2 + line1.upper()

	if inst_on and line1.find(';')>0 : # end of the cell description
		inst_on = False
		if del_on :  # change the busses delimiter
			line2 = line2.replace('\[','\<').replace('\]','\>')
		pins=[]  # list of pins
		nodes=[]  # list of netlist nodes
		words = line2.upper().rstrip('\r\n').strip().split('.')
		all_pins = '  '
		for word in words :
			pins.append(word[:word.find('(')])
			nodes.append(word[word.find('(')+1:word.find(')')])
		i = 0
		while subckt != cells[i][0] and i < len(cells) : # search for the cell on the list of cells stored with the SPICE
			i += 1
		if i == len(cells) :
			print ('ERROR : subckt ' + subckt + ' not found in the Spice netlist !')
			nb_subckt += 1
		else :
			inst_name = instance
			for pin in range(1,len(cells[i])) : # search for the pins of the SPICE subckt
				if cells[i][pin] == pos_pwr :
					instance = instance + ' ' + pos_pwr
				elif cells[i][pin] == neg_pwr :
					instance = instance + ' ' + neg_pwr
				else :
					j = 0
					while cells[i][pin] != pins[j] and j < len(pins) : # if the verilog pin name = spice pin name
						j += 1
					if j == len(nodes) :
						print ( 'ERROR : pin ' + cells[i][pin] + ' of the Spice netlist not found for the cell ' + inst_name + ' of the Verilog netlist !')
						nb_pins += 1
					else :
						instance = instance + ' ' + nodes[j]
			# print (instance + ' ' + subckt)
			outfl.write(instance + ' ' + subckt + '\n')

outfl.write('\n' + '.ENDS ' + subckt_name )

if nb_subckt > 0 :
	print ('\nERROR : during the translation : ' + str(nb_subckt) + ' cells from the VERILOG netlist not found in the SPICE netlist !\n')
if nb_pins > 0 :
	print ('\nERROR : during the translation : ' + str(nb_pins) + ' pins from the VERILOG netlist not found in the SPICE netlist !\n')
if nb_subckt + nb_pins == 0 :
	print (ver_file + ' : VERILOG netlist successfully translated to the SPICE netlist : ' + out_file + '\n')

verfl.close()
outfl.close()

exit(0) # Successful exit

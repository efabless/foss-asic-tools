#cascode bias circuit to be intigrated into opamps

proc shift_to_center {} {
	set res1 [box size]
	move [expr {-[lindex $res1 0] / 2}]i [expr {-[lindex $res1 1] / 2}]i
}

proc place_nmos {x_center y_center width length nf index} {
	puts $x_center
	select clear
	box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um  
	magic::gencell sky130::sky130_fd_pr__nfet_g5v0d10v5 [format "xm%d" $index] w $width l $length nf $nf m 1 diffcov 100 polycov 60 poverlap 0 doverlap 1 topc 1 botc 1 guard 0 full_metal 0 viagate 40
	shift_to_center
}

proc place_nmos_narrow {x_center y_center width length nf index} {
	puts $x_center
	select clear
	box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um  
	magic::gencell sky130::sky130_fd_pr__nfet_g5v0d10v5 [format "xm%d" $index] w $width l $length nf $nf m 1 diffcov 100 polycov 100 poverlap 0 doverlap 1 topc 1 botc 1 guard 0 full_metal 0 viagate 0
	shift_to_center
}

proc place_pmos {x_center y_center width length nf index} {
	select clear
	box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um  
	magic::gencell sky130::sky130_fd_pr__pfet_g5v0d10v5 [format "xm%d" $index] w $width l $length nf $nf m 1 diffcov 100 polycov 60 poverlap 0 doverlap 1 topc 1 botc 1 guard 0 full_metal 0 viagate 40
	shift_to_center
}

#draws guard ring for 5V0 pmos
proc draw_nguard {lx ly ux uy} {

	set center_x [expr ($lx + $ux)/2]
	set center_y [expr ($ly + $uy)/2]

	box [expr $center_x]um [expr $center_y]um [expr $center_x]um [expr $center_y]um
	pushbox
	#load dict 

	set parameters [sky130::sky130_fd_pr__pfet_g5v0d10v5_defaults]
	#param dict copied from sky130::sky130_fd_pr__pfet_g5v0d10v5_draw
	set newdict [dict create \
	gate_type		mvpfet \
	diff_type 		mvpdiff \
	diff_contact_type	mvpdc \
	plus_diff_type	mvnsd \
	plus_contact_type	mvnsc \
	poly_type		poly \
	poly_contact_type	pc \
	sub_type		nwell \
	dev_sub_type	nwell \
	guard_sub_surround	0.33 \
	gate_to_polycont	0.32 \
	diff_spacing	0.31 \
	diff_tap_space	0.38 \
	diff_gate_space	0.38 \
	]
	set drawdict [dict merge $sky130::ruleset $newdict $parameters]
	dict set drawdict viagb 100
	dict set drawdict viagt 100
	dict set drawdict viagr 90
	dict set drawdict viagl 90
	dict set drawdict contact_size 0.8
	dict set drawdict via_size 0.8
	dict set drawdict full_metal 1

	set contact_size [dict get $drawdict contact_size]
	set diff_surround [dict get $drawdict diff_surround]
	set guard_sub_surround [dict get $drawdict guard_sub_surround] 
	set sub_surround [dict get $drawdict sub_surround]

	#calculate gx and gy 

	set gw [expr ($ux-$lx - ($contact_size + $diff_surround + $diff_surround + $sub_surround + $sub_surround) - 0.3)]
	set gh [expr ($uy-$ly - ($contact_size + $diff_surround + $diff_surround + $sub_surround + $sub_surround) - 0.3)]


	sky130::guard_ring $gw $gh $drawdict
	#finish painting metal 
	box [expr $center_x - $gw/2 - $contact_size/2 - 0.03]um [expr $center_y - $gh/2 - $contact_size/2 - 0.03]um [expr $center_x - $gw/2 + $contact_size/2 + 0.03]um [expr $center_y + $gh/2 + $contact_size/2 + 0.03]um
	paint m1
	box [expr $center_x + $gw/2 - $contact_size/2 - 0.03]um [expr $center_y - $gh/2 - $contact_size/2 - 0.03]um [expr $center_x + $gw/2 + $contact_size/2 + 0.03]um [expr $center_y + $gh/2 + $contact_size/2 + 0.03]um
	paint m1

	#connection to m4 power rail
	#3x1.5 via in the corners
	#top right via
	box [expr $center_x + $gw/2 - $contact_size/2 - 0.03 -3]um [expr $center_y + $gh/2 - $contact_size/2 - 0.03 - 1.5]um [expr $center_x + $gw/2 - $contact_size/2 - 0.03]um [expr $center_y + $gh/2 - $contact_size/2 - 0.03]um
	sky130::via1_draw
	sky130::via2_draw
	sky130::via3_draw

	box [expr $center_x - $gw/2 + $contact_size/2 + 0.03]um [expr $center_y + $gh/2 - $contact_size/2 - 0.03 - 1.5]um [expr $center_x - $gw/2 + $contact_size/2 + 0.03 + 3]um [expr $center_y + $gh/2 - $contact_size/2 - 0.03]um
	sky130::via1_draw
	sky130::via2_draw
	sky130::via3_draw


}

#guard ring for nmos
#if you place pguard and nguard too close things get oddly shifted
proc draw_pguard {lx ly ux uy} {

	set center_x [expr ($lx + $ux)/2]
	set center_y [expr ($ly + $uy)/2]

	box [expr $center_x]um [expr $center_y]um [expr $center_x]um [expr $center_y]um
	pushbox
	#load dict 

	set parameters [sky130::sky130_fd_pr__nfet_g5v0d10v5_defaults]
	#param dict copied from sky130::sky130_fd_pr__nfet_g5v0d10v5_draw
	set newdict [dict create \
	    gate_type		mvnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    guard_sub_surround	0.33 \
	    diff_spacing	0.31 \
	    diff_tap_space	0.38 \
	    diff_gate_space	0.38 \
    ]
	set drawdict [dict merge $sky130::ruleset $newdict $parameters]
	dict set drawdict viagb 100
	dict set drawdict viagt 100
	dict set drawdict viagr 90 
	dict set drawdict viagl 90
	dict set drawdict contact_size 0.8
	dict set drawdict via_size 0.8
	dict set drawdict full_metal 1

	set contact_size [dict get $drawdict contact_size]
	set diff_surround [dict get $drawdict diff_surround]
	set guard_sub_surround [dict get $drawdict guard_sub_surround] 
	set sub_surround [dict get $drawdict sub_surround]

	#calculate gx and gy 

	set gw [expr ($ux-$lx - ($contact_size + $diff_surround + $diff_surround + $sub_surround + $sub_surround) - 0.3)]
	set gh [expr ($uy-$ly - ($contact_size + $diff_surround + $diff_surround + $sub_surround + $sub_surround) - 0.3)]

	sky130::guard_ring $gw $gh $drawdict

	#finish painting metal 
	box [expr $center_x - $gw/2 - $contact_size/2 - 0.03]um [expr $center_y - $gh/2 - $contact_size/2 - 0.03]um [expr $center_x - $gw/2 + $contact_size/2 + 0.03]um [expr $center_y + $gh/2 + $contact_size/2 + 0.03]um
	paint m1
	box [expr $center_x + $gw/2 - $contact_size/2 - 0.03]um [expr $center_y - $gh/2 - $contact_size/2 - 0.03]um [expr $center_x + $gw/2 + $contact_size/2 + 0.03]um [expr $center_y + $gh/2 + $contact_size/2 + 0.03]um
	paint m1

	#connection to m4 power rail
	#3x1.5 via in the corners
	#bottom right via
	box [expr $center_x + $gw/2 - $contact_size/2 - 0.03 -3]um [expr $center_y - $gh/2 + $contact_size/2 + 0.03]um [expr $center_x + $gw/2 - $contact_size/2 - 0.03]um [expr $center_y - $gh/2 + $contact_size/2 + 0.03 + 1.5]um
	sky130::via1_draw
	sky130::via2_draw
	sky130::via3_draw

	box [expr $center_x - $gw/2 + $contact_size/2 + 0.03]um [expr $center_y - $gh/2 + $contact_size/2 + 0.03]um [expr $center_x - $gw/2 + $contact_size/2 + 0.03 + 3]um [expr $center_y - $gh/2 + $contact_size/2 + 0.03 + 1.5]um
	sky130::via1_draw
	sky130::via2_draw
	sky130::via3_draw


}


#define cell boundaries 
#45um total cell height, variable cell width 

set cell_lx -60
set cell_ux 60

#do not change cell height
set cell_ly 0 
set cell_uy 45

set power_rail_width 4

set power_rail_layers "m4"

set vdd_rail_name "vdd"
set vss_rail_name "vss"


load oscillator 




#make cap

set cap_x -35
set cap_y -21.5

box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow center 15um
box grow e 2um 
paint mimcap 
box grow center 0.5um 
paint m3
paint m4
box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow n 15um 
box grow s 15um 
box grow e 2um 
move e 15um 
box shrink center 0.25um
paint mimcapcontact

box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow center 15um
box grow s 2um
paint mimcap2
box grow center 0.5um
paint m4
paint m5
box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow e 15um
box grow w 15um
box grow s 2um 
move s 15um 
box shrink center 0.25um
paint mimcap2contact

set cap_x -35
set cap_y 24.5

box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow center 15um
box grow e 2um 
paint mimcap 
box grow center 0.5um 
paint m3
paint m4
box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow n 15um 
box grow s 15um 
box grow e 2um 
move e 15um 
box shrink center 0.25um
paint mimcapcontact

box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow center 15um
box grow s 2um
paint mimcap2
box grow center 0.5um
paint m4
paint m5
box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow e 15um
box grow w 15um
box grow s 2um 
move s 15um 
box shrink center 0.25um
paint mimcap2contact

set cap_x -0
set cap_y 24.5

box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow center 15um
box grow e 2um 
paint mimcap 
box grow center 0.5um 
paint m3
paint m4
box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow n 15um 
box grow s 15um 
box grow e 2um 
move e 15um 
box shrink center 0.25um
paint mimcapcontact

box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow center 15um
box grow s 2um
paint mimcap2
box grow center 0.5um
paint m4
paint m5
box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow e 15um
box grow w 15um
box grow s 2um 
move s 15um 
box shrink center 0.25um
paint mimcap2contact

set cap_x 35
set cap_y 24.5

box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow center 15um
box grow e 2um 
paint mimcap 
box grow center 0.5um 
paint m3
paint m4
box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow n 15um 
box grow s 15um 
box grow e 2um 
move e 15um 
box shrink center 0.25um
paint mimcapcontact

box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow center 15um
box grow s 2um
paint mimcap2
box grow center 0.5um
paint m4
paint m5
box [expr $cap_x]um [expr $cap_y]um [expr $cap_x]um [expr $cap_y]um
box grow e 15um
box grow w 15um
box grow s 2um 
move s 15um 
box shrink center 0.25um
paint mimcap2contact


draw_nguard 5 -45 55 -23

draw_pguard 5 -22 55 0


#draw guard ring for nfets
#draw_pguard [expr $cell_lx] [expr $cell_ly] [expr $cell_ux] -0.2

#draw_pguard [expr $cell_ux] [expr $cell_ly] [expr $cell_ux +50] -0.2


#place power rails 
#this should not need to be modified

#top power rail
# lx ly ux xy
box [expr $cell_lx]um [expr $cell_uy - $power_rail_width]um [expr $cell_ux]um [expr $cell_uy]um
paint $power_rail_layers
#label rail 
box [expr $cell_lx]um [expr $cell_uy - $power_rail_width]um [expr $cell_lx]um [expr $cell_uy]um
label $vdd_rail_name FreeSans 30
findlabel $vdd_rail_name
port make 

#bottom power rail 
box [expr $cell_lx]um [expr $cell_ly]um [expr $cell_ux]um [expr $cell_ly + $power_rail_width]um
paint $power_rail_layers
#label rail 
box [expr $cell_lx]um [expr $cell_ly]um [expr $cell_lx]um [expr $cell_ly + $power_rail_width]um
label $vss_rail_name FreeSans 30
findlabel $vss_rail_name
port make 

#bottom power rail 
box [expr $cell_lx]um [expr $cell_ly - $power_rail_width ]um [expr $cell_ux]um [expr $cell_ly]um
paint $power_rail_layers


#bottom power rail 
box [expr $cell_lx]um [expr -$cell_uy]um [expr $cell_ux]um [expr -$cell_uy + $power_rail_width]um
paint $power_rail_layers

#vertical M5 power tie 
box [expr $cell_lx]um [expr -$cell_uy]um [expr $cell_lx + 5]um [expr $cell_uy]um
paint metal5

#M5 vias
box [expr $cell_lx + 2.5]um [expr -$cell_uy + 2]um [expr $cell_lx + 2.5]um [expr -$cell_uy + 2]um
box grow center 1.5um
paint via4

box [expr $cell_lx + 2.5]um [expr $cell_uy - 2]um [expr $cell_lx + 2.5]um [expr $cell_uy - 2]um
box grow center 1.5um
paint via4

#input / output labels 
box [expr $cell_lx]um -25um [expr $cell_lx + 4]um -23um
paint metal3

label iramp FreeSans 50 0 0 0 c metal3
port make

box [expr $cell_ux - 4]um -25um [expr $cell_ux]um -23um
paint metal3

label timeout_int FreeSans 50 0 0 0 c metal3
port make

#power rails label 
box [expr $cell_lx]um [expr -$cell_uy]um [expr $cell_lx + 1]um [expr -$cell_uy + $power_rail_width]um
label vpwr FreeSans 50 0 0 0 c metal5
port make

box [expr $cell_lx]um [expr -$power_rail_width]um [expr $cell_lx + 1]um [expr $power_rail_width]um
label vgnd FreeSans 50 0 0 0 c metal5
port make

#add logic cells

box -12um -22um -12um -22um 
getcell sky130_fd_sc_hvl__schmittbuf_1 v child 0 0 

box -6.5um -22um -6.5um -22um
getcell sky130_fd_sc_hvl__inv_1 v child ll
box -5um -22um -5um -22um
getcell sky130_fd_sc_hvl__inv_4 v child ll
box -1um -22um -1um -22um
getcell sky130_fd_sc_hvl__inv_4 v child ll
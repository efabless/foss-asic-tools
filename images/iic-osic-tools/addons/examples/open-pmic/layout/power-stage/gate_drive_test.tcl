set parameters [sky130::sky130_fd_pr__pfet_g5v0d10v5_defaults]



set newdict [dict create \
	    gate_type		mvnfet \
	    diff_type 		mvndiff \
	    diff_contact_type	mvndc \
	    plus_diff_type	mvpsd \
	    plus_contact_type	mvpsc \
	    poly_type		poly \
	    poly_contact_type	pc \
	    sub_type		psub \
	    diff_spacing	0.31 \
	    diff_tap_space	0.38 \
	    diff_gate_space	0.38 \
    ]


set drawdict [dict merge $sky130::ruleset $newdict $parameters]


dict set drawdict full_metal 0
dict set drawdict guard 0
dict set drawdict w 20
dict set drawdict nf 10
dict set drawdict polycov 60
dict set drawdict viagate 50
dict set diff_spacing  -0.12


puts $drawdict


sky130::mos_draw $drawdict
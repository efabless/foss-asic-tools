#!/usr/bin/env wish
#--------------------------------------------
# Script to generate .mag files from .gds    
#--------------------------------------------
crashbackups stop
drc off
gds readonly true
gds flatten true
gds rescale false
tech unlock *
# Special options passed to magic for GDS import of the I/O library cells.
# This line flattens all the cells containing "__example_" in the name,
# which includes all contacts and primitive devices.  This prevents the
# primitive devices from being split across the hierarchy, which causes
# magic to misinterpret the device type.
gds flatglob *__example_*
cif istyle sky130(vendor)
gds read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io.gds
gds read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__analog.gds
gds read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__bare_pad.gds
gds read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__connect_vcchib_vccd_and_vswitch_vddio_slice_20um.gds
gds read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__disconnect_vccd_slice_5um.gds
gds read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__disconnect_vdda_slice_5um.gds
gds read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__gpiov2_pad_wrapped.gds
gds read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_fd_io.gds
puts stdout "Annotating cells from LEF"
lef read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io.lef
lef read /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_ef_io.lef
puts stdout "Annotating cells from CDL/SPICE"
catch {readspice /home/mk/foss/pdks/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/cdl/sky130_ef_io.cdl}
puts stdout "Writing all magic database files"
writeall force
puts stdout "Done."
quit -noprompt

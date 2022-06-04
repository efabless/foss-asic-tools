# sky130-analog
A repo for some designs on the sky130 open PDK. Focus is on analog and power electronics. These designs are intended to eventually serve as basic building blocks for more complex projects. 

# Toolchain 
Right now everything is in the simulation stage and pre-layout. Schematic capture is done with Xschem and simulation is done with Ngspice. Follow this tutorial by bluecmd to set things up https://github.com/bluecmd/learn-sky130

# Structure 
## [Transistor Characterization](device)
Some basic spice DC sweeps to extract transistor parameters to enable hand calculations


# Designs 
## [Basic Opamp](designs/basic_opa)
  A basic folded cascode opamp based on the design presented in Fig 6.20 in Analog Integrated Circuit Design 2nd Edition. Transistor sizing is adjusted for the sky130 process. This design needs a bias circuit before it can be layed out. 




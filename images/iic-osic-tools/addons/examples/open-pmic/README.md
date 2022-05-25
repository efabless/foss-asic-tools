# open-pmic
A current mode buck converter on the SKY130 PDK. 
A Stanford EE272B class project by Weston Braun and Aparna Tumkur

Project Proposal: https://docs.google.com/document/d/1ybBBiQdKpzqJREbku2Ojv6pWsStpCbY1eh7hGmEWyLY/edit?usp=sharing
Proposal Presentation: https://docs.google.com/presentation/d/1cBQSitbgofe7c7ZFHN6wEK7AjSlTb3CQkrHIqdwXP6I/edit?usp=sharing
Design Review: https://docs.google.com/presentation/d/1vPasXV9Lbhd-kNUkEiaC2Bks8IbjNlcl0WMSGZ9YmyA/edit?usp=sharing

This project uses a fully open source toolchain. 
Xschem for schematic capture
ngspice for simulation 
Magic for layout
See http://www.opencircuitdesign.com/ for toolchain setup

# Structure
Schematics and analog simulation testbenches are in open-pmic/design. 
Layout files are in open-pmic/layout

# Simulation
There is not yet a standarized way to distribute a xschem configureation file with projects, as the xschem configuration file encodes the user specific location of the sky130 PDK. 
For correct maping of the project schematic symbols add the base project directory to your xschemrc file and set SKYWATER_STDCELLS to point to the sky130_fd_sc_hvl logic cell library.
open-pmic/design/system/full_system_tb.sch is the top level simulation testbench. 


# Status 
The design simulates with a simplified I/O model. See open-pmic/design/system/full_system_tb.sch
Layout to begin shortly. 


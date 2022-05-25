## Layout Guidelines

### Analog
Analog blocks on 45um cell height with power rails on m4
Guard ring on m1 for pmos and nmos regions.
m1 for interconnect between mos of same type
m2 for interconnect between well regions

All initial MOS placement scripted. See example tcl scripts

Within Cell:
metal 1 for horizontal routing
metal 2 for vertical routing
metal 1 and metal 2: 0.3um track with 0.2um space
No routing metal above mos channel

metal 3 for interconnect between cells

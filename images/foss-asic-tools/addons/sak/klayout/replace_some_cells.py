#!/usr/bin/env python3
import subprocess
import argparse
import os

parser = argparse.ArgumentParser(
    description='Replaces a portion of the cells with others from the library.')

parser.add_argument('--probability', '-p', type=float, required=True,
                    default=1.0,
                    help='')

parser.add_argument('--design-name', '-name', required=True)

parser.add_argument('--from-cell-prefix', '-from', required=True, nargs='+')
parser.add_argument('--to-cell-prefix', '-to', required=True, nargs='+')

parser.add_argument('--user-gds', '-design', required=True)
parser.add_argument('--library-gds', '-library', required=True, nargs='+')

parser.add_argument('--output-gds', '-o', required=True)

parser.add_argument('--xor', action='store_true',
                    default=False,
                    help='Produce an XOR GDS of the output_gds vs the original user_gds.'
                    'In the same output directory as output_gds')

args = parser.parse_args()

probability = args.probability

design_name = args.design_name

from_cell_prefix = args.from_cell_prefix
to_cell_prefix = args.to_cell_prefix

user_gds = args.user_gds
library_gds = args.library_gds
output_gds = args.output_gds

xor_flag = args.xor

klayout_cmd = f"klayout -zz \
    -rd design_name={design_name} \
    -rd from_cell_prefix={','.join(from_cell_prefix)} \
    -rd to_cell_prefix={','.join(to_cell_prefix)} \
    -rd library_gds={','.join(library_gds)} \
    -rd user_gds={user_gds} \
    -rd output_gds={output_gds} \
    -rd probability={probability} \
    -rm tmp.py"

klayout_code=r"""
import pya
from random import random, seed

seed(a=0)

app = pya.Application.instance()
win = app.main_window()

# design_name = 'manual_macro_placement_test'

# from_cell_prefix = 'sky130_fd_sc_hd__decap'
# to_cell_prefix = 'sky130_fd_sc_hd__fill'

# library_gds = '/home/xrex/usr/devel/pdks/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd.gds'
# user_gds = '/home/xrex/usr/devel/openlane_develop/designs/manual_macro_placement_test/runs/test/results/magic/manual_macro_placement_test.gds'
# output_gds = '/home/xrex/usr/devel/openlane_develop/designs/manual_macro_placement_test/runs/test/results/magic/out.gds'

# probability = 1.0

#######

library_gds = library_gds.split(',')
from_cell_prefix = from_cell_prefix.split(',')
to_cell_prefix = to_cell_prefix.split(',')

from_cells = []
to_cells = []

user_layout = pya.Layout()

for gds in library_gds:
    print("Reading", gds)
    user_layout.read(gds)

# find the cells we're interested in (flat cell list)
for cell in user_layout.each_cell():
    cell_name = cell.name

    for prefix in from_cell_prefix:
        if cell_name.startswith(prefix):
            assert cell not in from_cells
            from_cells.append(cell)

    for prefix in to_cell_prefix:
        if cell_name.startswith(prefix):
            assert cell not in to_cells
            to_cells.append(cell)

print("From:", [c.name for c in from_cells])
print("To:", [c.name for c in to_cells])

subst_dict = {}
for cell_from in from_cells:
    cell_from_width = cell_from.bbox().width()
    for cell_to in to_cells:
        cell_to_width = cell_to.bbox().width()
        if cell_to_width == cell_from_width:
            subst_dict[cell_from.name] = cell_to
            break

    subst_dict.setdefault(cell_from.name, None)

print('-'*10)

for k, v in subst_dict.items():
    if v:
        print("Found a substitution", k, "->", v.name)

print('-'*10)

##############################

matching_insts = []

def add_if_matching_cell(inst):
    cell_name = inst.cell.name
    # print("DBUG: Checking", cell_name)
    for prefix in from_cell_prefix:
        if cell_name.startswith(prefix):
            matching_insts.append(inst)

def print_cell_name(inst):
    pass

def substitute_matching_cell(inst):
    cell_name = inst.cell.name
    assert cell_name in subst_dict
    if subst_dict[cell_name] is not None:
        # print("DBUG: Replacing", cell_name, end=' ')
        # print("with", subst_dict[cell_name].name)
        inst.cell = subst_dict[cell_name]

def exec_for_each_inst(cell, func):
    # print("DBUG_CELL:", cell.name)
    for inst in cell.each_inst():
        # print("    DBUG_INST:", inst.cell.name)
        assert inst is not None

        # for cells that have no hierarchy beneath (standard cells in this case)
        if inst.cell.hierarchy_levels() == 0:
            func(inst)

        # for macros
    for child_idx in cell.each_child_cell():
        cell = user_layout.cell(child_idx)
        if cell.hierarchy_levels() > 0:
            # print("DBUG_CHILD:", cell.name)
            exec_for_each_inst(cell, func)

user_layout.read(user_gds)

top_cell = user_layout.cell(design_name)

print("Top-cell name:", top_cell.name)

exec_for_each_inst(top_cell, add_if_matching_cell)

subst_cnt = 0
tot = len(matching_insts)
for inst in matching_insts:
    if random() <= float(probability):
        subst_cnt += 1
        substitute_matching_cell(inst)

print("Substituted", subst_cnt, "out of", tot, "substitutable cells")

# delete the rest of the top-level cells
####### revise this:
for cell in user_layout.top_cells():
    if cell.name != design_name:
        cell.delete()

for cell in user_layout.top_cells():
    if cell.name != design_name:
        cell.delete()

user_layout.write(output_gds)

print("Successfully wrote", output_gds)
"""

with open("tmp.py", "w") as f:
    f.write(klayout_code)

try:
    print("Executing:")
    print(klayout_cmd)
    output = subprocess.call(klayout_cmd.split())
except:
    print("KLayout script failed")
finally:
    pass
    os.remove('tmp.py')

if xor_flag:
    print("Running XOR on the result against the original user GDS.")
    output_xor_file_name = os.path.splitext(output_gds)[0] + '.xor.gds'
    xor_cmd = f"sh {os.path.dirname(os.path.realpath(__file__))}/xor.sh {output_gds} {user_gds} {design_name} {output_xor_file_name}"
    try:
        print("Executing:")
        print(xor_cmd)
        output = subprocess.call(xor_cmd.split())
    except:
        print("XOR script failed")

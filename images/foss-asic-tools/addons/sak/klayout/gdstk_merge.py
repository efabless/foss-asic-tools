# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

# Use caravel_xxxxyyyy as the golden caravel
from pathlib import Path
import gdstk
import argparse
import os.path
import sys


def gdstk_merge(layout_caravel, layout_merge):
    # Now we load the existing libraries
    lib2 = []
    if caravel_oas:
        lib1 = gdstk.read_oas(layout_caravel)
    else:
        lib1 = gdstk.read_gds(layout_caravel)
    if merge_oas:
        for layout in layout_merge:
            lib2.append(gdstk.read_oas(layout))
    else:
        for layout in layout_merge:
            lib2.append(gdstk.read_gds(layout_merge))

    lib1 = change_uid(lib1)

    # We add all cells from the second library to the first
    lib1_cell_names = set(c.name for c in lib1.cells)
    for libs in lib2:
        for cell in libs.cells:
            # check if the cell already exist, if it does then replace it
            if cell.name in lib1_cell_names:
                lib1.replace(cell)
            # Now we add the cell and update the set of names
            lib1.add(cell)
            lib1_cell_names.add(cell.name)

    lib1.write_gds("caravel_" + user_id_value + ".gds")


def change_uid(lib):
    for cells in lib.cells:
        if "xxxxyyyy" in cells.name:
            cells.name = cells.name.replace("xxxxyyyy", user_id_value)
            assert cells.name
    return lib



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-uid", "--user_id", required=True, type=str, help="User ID character string of eight hex digits")
    parser.add_argument("-l1", "--layout1_path", required=True, type=Path, help="template caravel path")
    parser.add_argument("-l2", "--layout2_path", required=True, type=Path, help="gds to get merged file path", nargs=2)
    args = parser.parse_args()

    layout_merge = []

    layout_caravel = Path(args.layout1_path).absolute()
    user_id_value = args.user_id
    
    for layout in args.layout2_path:
        layout_merge.append(Path(layout).absolute())

    extension = os.path.splitext(layout_caravel)[1]
    if extension == ".oas":
        caravel_oas = True
    else:
        caravel_oas = False
    
    extension = os.path.splitext(layout_merge[0])[1]
    if extension == ".oas":
        merge_oas = True
    else:
        merge_oas = False

    gdstk_merge(layout_caravel, layout_merge)

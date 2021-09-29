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

# klayout -rd file1=caravel_xxxxyyyy.oas -rd file2=user_project_wrapper.oas,caravel_<user_id>_fill_pattern.oas -rd user_id="<user_id>" -z -r merge_kl.py 

# Use caravel_xxxxyyyy as the golden caravel
import pya

def merge():
    files = file2.split(",")
    opt = pya.LoadLayoutOptions()
    opt_oas = pya.SaveLayoutOptions()
    ly = pya.Layout()

    for file in files:
        lmap = ly.read(file1)

        ly = change_uid(ly)

        opt.set_layer_map(lmap, True)
        ly.read(file, opt)

        ly.write(output)
    
    for cells in ly.each_cell():
        ci = cells.cell_index()
        if "$" in cells.name:
            ly.delete_cell_rec(ci)

    opt_oas.set_format_from_filename(output)
    opt_oas.oasis_substitution_char=''
    ly.write(output, opt_oas)

def change_uid(lib):
    for cells in lib.each_cell():
        ci = cells.cell_index()
        if "xxxxyyyy" in cells.name:
            name = cells.name.replace("xxxxyyyy", user_id)
            lib.rename_cell(ci, name)
    return lib

if __name__ == "__main__":
    output = "caravel_" + user_id + ".oas"
    merge()
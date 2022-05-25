#!/bin/python3.8
import klayout.db as pya
import klayout.rdb as rdb
import argparse
import time
import gc
from termcolor import colored
from pprint import pprint
from pathlib import Path

class Material:
    def __init__(self, name, bottom, list_of_tops):
        self.name = name
        self.bottom = bottom
        self.list_of_tops = list_of_tops

def mark_metal_purpose_not_overlapping_drawing(layout_path, markers_output_file, flat):
    layout_ut = pya.Layout()
    layout_ut.read(str(layout_path))
    report = rdb.ReportDatabase(str(markers_output_file))
    rdb_top_cell = report.create_cell(layout_ut.top_cell().name)

    if not flat:
        dss = pya.DeepShapeStore()
    materials = [
                    Material("nwell",    bottom=pya.LayerInfo(64,20),  list_of_tops=[pya.LayerInfo(64,16),pya.LayerInfo(64,5)]),
                    Material("diff",     bottom=pya.LayerInfo(65,20),  list_of_tops=[pya.LayerInfo(65,16),pya.LayerInfo(65,6)]),
                    Material("tap",      bottom=pya.LayerInfo(65,44),  list_of_tops=[pya.LayerInfo(65,48),pya.LayerInfo(65,5)]),
                    Material("poly",     bottom=pya.LayerInfo(66,20),  list_of_tops=[pya.LayerInfo(66,16),pya.LayerInfo(66,5)]),
                    Material("licon1",   bottom=pya.LayerInfo(66,44),  list_of_tops=[pya.LayerInfo(66,58)]),
                    Material("li1",      bottom=pya.LayerInfo(67,20),  list_of_tops=[pya.LayerInfo(67,16),pya.LayerInfo(67,5)]),
                    Material("mcon",     bottom=pya.LayerInfo(67,44),  list_of_tops=[pya.LayerInfo(67,48)]),
                    Material("met1",     bottom=pya.LayerInfo(68,20),  list_of_tops=[pya.LayerInfo(68,16),pya.LayerInfo(68,5)]),
                    Material("via",      bottom=pya.LayerInfo(68,44),  list_of_tops=[pya.LayerInfo(68,58)]),
                    Material("met2",     bottom=pya.LayerInfo(69,20),  list_of_tops=[pya.LayerInfo(69,16),pya.LayerInfo(69,5)]),
                    Material("via2",     bottom=pya.LayerInfo(69,44),  list_of_tops=[pya.LayerInfo(69,58)]),
                    Material("met3",     bottom=pya.LayerInfo(70,20),  list_of_tops=[pya.LayerInfo(70,16),pya.LayerInfo(70,5)]),
                    Material("via3",     bottom=pya.LayerInfo(70,44),  list_of_tops=[pya.LayerInfo(70,48)]),
                    Material("met4",     bottom=pya.LayerInfo(71,20),  list_of_tops=[pya.LayerInfo(71,16),pya.LayerInfo(71,5)]),
                    Material("via4",     bottom=pya.LayerInfo(71,44),  list_of_tops=[pya.LayerInfo(71,48)]),
                    Material("met5",     bottom=pya.LayerInfo(72,20),  list_of_tops=[pya.LayerInfo(72,16),pya.LayerInfo(72,5)]),
                    Material("pad",      bottom=pya.LayerInfo(76,20),  list_of_tops=[pya.LayerInfo(76,5),pya.LayerInfo(76,16)]),
                    Material("pnp",      bottom=pya.LayerInfo(82,44),  list_of_tops=[pya.LayerInfo(82,59)]),
                    Material("npn",      bottom=pya.LayerInfo(82,20),  list_of_tops=[pya.LayerInfo(82,5)]),
                    Material("rdl",      bottom=pya.LayerInfo(74,20),  list_of_tops=[pya.LayerInfo(74,16),pya.LayerInfo(74,5)]),
                    Material("inductor", bottom=pya.LayerInfo(82,24),  list_of_tops=[pya.LayerInfo(82,25)])]

    for amaterial in materials:
        print(f"{amaterial.name}")
        for atop in amaterial.list_of_tops:
            if not flat:
                layer_top = pya.Region(layout_ut.top_cell().begin_shapes_rec(layout_ut.layer(atop.layer, atop.datatype)), dss)
                layer_bot = pya.Region(layout_ut.top_cell().begin_shapes_rec(layout_ut.layer(amaterial.bottom.layer, amaterial.bottom.datatype)), dss)
            else:
                layer_top = pya.Region(layout_ut.top_cell().begin_shapes_rec(layout_ut.layer(atop.layer, atop.datatype)))
                layer_bot = pya.Region(layout_ut.top_cell().begin_shapes_rec(layout_ut.layer(amaterial.bottom.layer, amaterial.bottom.datatype)))

            msg = f"{atop.layer}/{atop.datatype} over {amaterial.bottom.layer}/{amaterial.bottom.datatype}"
            print(f"{msg:>40} ", end="")
            violating_region = layer_top - layer_bot

            if violating_region.is_empty():
                print(colored(f"{'SUCCESS':^50}", "green"))
            else:
                print(colored(f"{'FAILURE':^50}", "red"))
            category_inst = report.create_category(f"{atop.layer}/{atop.datatype}")
            report.create_items(rdb_top_cell.rdb_id(), category_inst.rdb_id(), pya.CplxTrans(layout_ut.dbu), violating_region)
            del violating_region
            del layer_top
            gc.collect()
        del layer_bot
        gc.collect()
    report.save(str(markers_output_file))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--layout_path", required=True, type=Path, help="Layout path")
    parser.add_argument("-m", "--markers_output_file", required=True, type=Path, help="Violating shapes markers file path")
    parser.add_argument("-f", "--flat", required=False, action="store_true", help="Specify flat mode analysis (versus deep), default: False")
    args = parser.parse_args()
    layout_path = Path(args.layout_path).absolute()
    markers_output_file = Path(args.markers_output_file).absolute()
    mark_metal_purpose_not_overlapping_drawing(layout_path, markers_output_file, args.flat)

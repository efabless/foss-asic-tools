#!/bin/python3.8
import os
import gc
import argparse
import re
import logging
import sys
from pathlib import Path

import coloredlogs
import klayout.db as pya
import klayout.rdb as rdb
from termcolor import colored

# Needed for script wide deep mode analysis
global_dss = None


def cell_xor(cella, cellb, flat):
    violation_region = pya.Region()
    # To have all possible layers between the two cells
    for layer_info in set([*cella.layout().layer_infos(), *cellb.layout().layer_infos()]):
        cella_layer = cella.begin_shapes_rec(cella.layout().layer(layer_info.layer, layer_info.datatype))
        cellb_layer = cellb.begin_shapes_rec(cellb.layout().layer(layer_info.layer, layer_info.datatype))
        if not flat:
            violation_region.insert(pya.Region(cella_layer, global_dss) ^ pya.Region(cellb_layer, global_dss))
        else:
            violation_region.insert(pya.Region(cella_layer) ^ pya.Region(cellb_layer))
        del cella_layer
        del cellb_layer
        gc.collect()
    return violation_region

def cell_freshness_check(layout_path, pdk_root, break_on_single_rotten_cell, flat, check_sram_cells, close_matching, markers_output_file):
    report = rdb.ReportDatabase("Cell Freshness Check")
    layout_ut = pya.Layout()
    layout_ut.read(str(layout_path))
    sky130A_pdk_layouts_list = []
    for path in list((pdk_root / 'sky130A/libs.ref/').rglob('*.gds')):
        if not check_sram_cells and 'sram' in path.name:
            continue
        else:
            sky130A_pdk_cells_layout = pya.Layout()
            sky130A_pdk_cells_layout.read(str(path))
            sky130A_pdk_layouts_list.append(sky130A_pdk_cells_layout)

    sky130A_pdk_cells = {}
    for asky130A_pdk_layout in sky130A_pdk_layouts_list:
        for sky130A_pdk_cell in asky130A_pdk_layout.top_cells():
            sky130A_pdk_cells[sky130A_pdk_cell.name] = sky130A_pdk_cell
    layout_ut_cells = {layout_ut_cell.name: layout_ut_cell for layout_ut_cell in layout_ut.each_cell()}

    test_matches = {}
    # This is needed because some tools add some prefixes to the cell name while writing gds (example: magic)
    if close_matching:
        for layout_ut_cell in layout_ut_cells.values():
            for sky130A_pdk_cell in sky130A_pdk_cells.values():
                # This workaround exists specifically for magic to adhere to some prefix addition to cell name
                # TODO: might need removal later on
                if sky130A_pdk_cell.name == layout_ut_cell.name or re.match(layout_ut_cell.name, rf".*_{sky130A_pdk_cell.name}$"):
                    test_matches[layout_ut_cell] = sky130A_pdk_cell
    else:
        for layout_ut_cell in layout_ut_cells.values():
            if layout_ut_cell.name in sky130A_pdk_cells:
                test_matches[layout_ut_cell] = sky130A_pdk_cells[layout_ut_cell.name]

    #TODO:remove all prints in favor of logging
    rotten_cells = {}
    fresh_cells = {}
    logging.info(f"{'sky130 pdk':<50}{layout_path.stem:<70}EQUIVALENT")
    logging.info(f"{'':_<130}")
    for layout_ut_cell, sky130A_pdk_cell in test_matches.items():
        logging.root.handlers[0].terminator = ""
        logging.info(f"{sky130A_pdk_cell.name:<50}{layout_ut_cell.name:<70}")
        logging.root.handlers[0].terminator ="\n"
        difference = cell_xor(cella=sky130A_pdk_cell, cellb=layout_ut_cell, flat=flat)
        if difference.is_empty():
            logging.info(colored("YES", "green"))
            fresh_cells[layout_ut_cell.name] = layout_ut_cell
        else:
            logging.error(colored("NO", "red"))
            rotten_cells[layout_ut_cell.name] = layout_ut_cell
            category_inst = report.create_category(f"PDK {sky130A_pdk_cell.name} compared to {layout_path.name} {layout_ut_cell.name}")
            report.create_items(report.create_cell(layout_ut_cell.name).rdb_id(), category_inst.rdb_id(),
                    pya.CplxTrans(layout_ut_cell.layout().dbu), difference)
            if break_on_single_rotten_cell:
                break
        # delete cell to free memory
        del layout_ut_cell
        del sky130A_pdk_cell
        gc.collect()
    logging.info( f"""\n{'Summary':_^130}\n
    sky130A_pdk
    {len(sky130A_pdk_cells):^30} sky130 cells
    {len([sky130A_pdk_cell for sky130A_pdk_cell in sky130A_pdk_cells.values() if sky130A_pdk_cell.is_ghost_cell()]):^30} sky130 ghost cells
    {layout_path.stem}
    {len(layout_ut_cells):^30} cells
    {len(rotten_cells):^30} Rotten sky130 Cells
    {len(fresh_cells):^30} Fresh sky130 Cells
    {len(layout_ut_cells) - len(fresh_cells) - len(rotten_cells):^30} Not-Tested Cells
    {len([layout_ut_cell for layout_ut_cell in layout_ut_cells.values() if layout_ut_cell.is_ghost_cell()]):^30} ghost cells""")
    if markers_output_file:
        report.save(str(markers_output_file))
    return len(rotten_cells) == 0

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--layout_path", required=True, type=Path, help="Layout path")
    parser.add_argument("-p", "--pdk_root", required=True, type=Path, help="PDK root directory")
    parser.add_argument("-b", "--break_on_single_rotten_cell", action="store_true", default=False, required=False,
            help="if specified the check exits on a single violation instead of running the check on all cells")
    parser.add_argument("-f", "--flat", action="store_true", default=False, required=False,
            help="enable flat mode analysis (instead of hierarchical)")
    parser.add_argument("-s", "--check_sram_cells", action="store_true", default=False, required=False,
            help="Run cell equivalency on ram cells, which are huge(very slow)")
    parser.add_argument("-c", "--close_matching", action="store_true", default=False, required=False,
            help="Comparison done between cells with names the resemble each other (as opposed to exactly matching which is default) ")
    parser.add_argument("-m", "--markers_output_file", required=False, type=Path, help="violating shapes markers file path")
    args = parser.parse_args()

    logging.basicConfig(level=logging.DEBUG, format=f"%(message)s", stream=sys.stdout)
    if not args.flat:
        # To enable faster analysis
        global_dss = pya.DeepShapeStore()
        # global_dss.threads = 4
        # global_dss.threads = os.cpu_count()
    cell_freshness_check(Path(args.layout_path).absolute(), Path(args.pdk_root).absolute(), args.break_on_single_rotten_cell,
            args.flat, args.check_sram_cells, args.close_matching, args.markers_output_file)

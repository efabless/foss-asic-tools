import klayout.rdb as rdb
import klayout.db as pya
import sys
from collections import Counter
import contextlib

kl_rd = rdb.ReportDatabase("klayout database")
kl_rd.load(str(sys.argv[1]))
cal_rd = rdb.ReportDatabase("calibre database")
cal_rd.load(str(sys.argv[2]))
diff_rd = rdb.ReportDatabase("diff database")
cat_cal=[]
cat_kl=[]
diff = []
cal_array = []

kl_cat_region = {}
cal_cat_region = {}
poly = 0

for kl in kl_rd.each_item():
    for value in kl.each_value():
        if value.is_edge_pair():
            poly = value.edge_pair().polygon(0)
        elif value.polygon():
            poly = value.polygon()
        if kl_rd.category_by_id(kl.category_id()).name() not in kl_cat_region:
            kl_cat_region[kl_rd.category_by_id(kl.category_id()).name()] = []
        kl_cat_region[kl_rd.category_by_id(kl.category_id()).name()].append(poly)

for cal in cal_rd.each_item():
    for value in cal.each_value():
        if value.is_edge_pair():
            poly = value.edge_pair().polygon(0)
        elif value.polygon():
            poly = value.polygon()
        if cal_rd.category_by_id(cal.category_id()).name().replace('MR_', '') not in cal_cat_region:
            cal_cat_region[cal_rd.category_by_id(cal.category_id()).name().replace('MR_', '')] = []
        cal_cat_region[cal_rd.category_by_id(cal.category_id()).name().replace('MR_', '')].append(poly)


for val in cal_cat_region.values():
    for v in val:
        cal_array.append(v)


for key, value in kl_cat_region.items():
    for val in value:
        if val not in cal_array:
            # print(val)
            diff.append([key, value])

for i in diff:
    cat = diff_rd.create_category(i[0])
    cell = diff_rd.create_cell(kl_rd.top_cell_name)
    item = diff_rd.create_item(cell, cat)
    for n in i[1]:
        item.add_value(n)

diff_rd.save(str(sys.argv[3]))

arr = []
for i in diff_rd.each_category():
    arr.append(i)
if len(arr) == 0:
    print("\033[1;32m Klayout and Calibre Match!")
else:
    print("\033[91m Klayout and Calibre Don't match!")

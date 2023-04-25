import klayout.rdb as rdb
import sys
from collections import Counter
import contextlib

kl_rd = rdb.ReportDatabase("klayout database")
kl_rd.load(str(sys.argv[1]))
cal_rd = rdb.ReportDatabase("calibre database")
cal_rd.load(str(sys.argv[2]))
cat_cal=[]
cat_kl=[]

for kl in kl_rd.each_item():
    cat_kl.append(kl_rd.category_by_id(kl.category_id()).name())
for kl in cal_rd.each_item():
    cat_cal.append(cal_rd.category_by_id(kl.category_id()).name().replace('MR_', ''))

categories_kl = Counter(cat_kl)
categories_cal = Counter(cat_cal)

with open(str(sys.argv[3]), 'w') as f:
    with contextlib.redirect_stdout(f):
        print('%-12s%-12s%-12s%s' % ('category', 'klayout', 'calibre', 'equivalent'))

        for c in categories_kl | categories_cal:
            if categories_kl[c] == categories_cal[c]:
                print('%-12s%-12d%-12d%s' % (c, categories_kl[c], categories_cal[c], 'yes'))
            else:
                print('%-12s%-12d%-12d%s' % (c, categories_kl[c], categories_cal[c], 'no'))

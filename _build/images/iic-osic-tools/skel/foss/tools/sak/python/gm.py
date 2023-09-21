#!/bin/python3

# gather all dbs and rdbs in the current directory into
# a ./dbs directory to be easily navigatable by klayout
# so that you can switch easily between markers

import os
from shutil import copyfile
from pathlib import Path
from glob import glob


def copy_all_dbs(ext):
    db_files = glob('./*/*.{ext}'.format(ext=ext))
    relative_path_db_files = [Path(filename) for filename in db_files]
    for afile in relative_path_db_files:
        os.makedirs('dbs', exist_ok=True)
        copyfile(str(afile), 'dbs/'+str(afile.parent)+'_'+afile.name)

if __name__ == "__main__":
    copy_all_dbs('db')
    copy_all_dbs('rdb')


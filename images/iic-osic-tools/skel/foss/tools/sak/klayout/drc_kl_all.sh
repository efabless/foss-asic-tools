#!/usr/bin/sh
/mnt/shuttles/precheck/drc_checks/drc_kl.sh $TAPEOUT_ROOT/precheck/tech-files/sky130A_mr.lydrc  $1  ${1}.kl.report.db .
klayout $1 -m ${1}.kl.report.db &

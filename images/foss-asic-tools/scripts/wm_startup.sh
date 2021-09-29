#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo -e "\n------------------ startup of Xfce4 window manager ------------------"

/usr/bin/startxfce4 > $STARTUPDIR/logs/wm.log &
sleep 1
cat $STARTUPDIR/logs/wm.log

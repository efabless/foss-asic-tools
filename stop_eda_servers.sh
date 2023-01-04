#!/bin/bash
#
# (c) 2023 Harald Pretl, Institute for Integrated Circuits, Johannes Kepler University, Linz, Austria
#
# Stops and removes multiple IIC-OSIC-TOOLS containers for many EDA users

DEBUG=0

while getopts "hd" flag; do
	case $flag in
		d)
			echo "[INFO] DEBUG is enabled"
			DEBUG=1
			;;
		h)
			echo "Stopping Docker instances for EDA users"
			echo "(c) 2023 Harald Pretl, Institute for Integrated Circuits, JKU"
			echo ""
			echo "Usage: $0 [-h] [-d]"
			echo ""
			echo "       -h shows a help screen"
			echo "       -d enables the debug mode"
			echo "" 
			exit
			;;
		*)
			;;
    esac
done
shift $((OPTIND-1))

# now search the containers and remove them
while [ "$(docker ps -q -f name="iic-osic-tools_eda_user")" ];
do
	CONTAINER_ID=$(docker ps -q -f name="iic-osic-tools_eda_user" | head -n1)
	[ $DEBUG = 1 ] && echo "[INFO] Container ID $CONTAINER_ID found, now stopping and removing!"
	docker stop "$CONTAINER_ID" > /dev/null
	docker rm "$CONTAINER_ID" > /dev/null
done	

echo "[DONE] EDA containers are stopped and removed, bye!"

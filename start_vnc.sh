#!/bin/bash

# Set the host ports, disable with 0. Only used if not set as a shell variables!
if [ -z ${WEBSERVER_PORT+z} ]; then
	WEBSERVER_PORT=80
fi
if [ -z ${VNC_PORT+z} ]; then
	VNC_PORT=0
fi
if [ -z ${DESIGNS+z} ]; then
	DESIGNS="~/designs"
fi

PORT_PARAMS=""
if [ $WEBSERVER_PORT -gt 0 ]; then
	PORT_PARAMS="$PORT_PARAMS -p $WEBSERVER_PORT:80"
fi
if [ $VNC_PORT -gt 0 ]; then
	PORT_PARAMS="$PORT_PARAMS -p $VNC_PORT:5901"
fi

docker run -d --user $(id -u):$(id -g) $PORT_PARAMS -v $DESIGNS:/foss/designs:rw foss-asic-tools:alpha

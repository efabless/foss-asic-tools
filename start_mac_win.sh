#!/bin/bash

# Set the local X-Server to listen on TCP

if [ -z ${DISP+z} ]; then
	DISP="host.docker.internal:6000"
fi

if [ -z ${DESIGNS+z} ]; then
        DESIGNS="~/designs"
fi

docker run -d --user $(id -u):$(id -g) -e DISPLAY=$DISP -v $DESIGNS:/foss/designs:rw foss-asic-tools:alpha

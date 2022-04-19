#!/bin/bash

# Senseful defaults (uses XAUTHORITY Shell variable if set, or the default .Xauthority-file in the caller home directory)
if [ -z ${XAUTHORITY+z} ]; then
	XAUTH="~/.Xauthority"
else
	XAUTH=$XAUTHORITY
fi

# Should also be a senseful default
if [ -z ${XSOCK+z} ]; then
	XSOCK="/tmp/.X11-unix"
fi

# SET YOU DESIGN PATH RIGHT!
if [ -z ${DESIGNS+z} ]; then
        DESIGNS="./designs"
fi

# Finally, run the container, sets DISPLAY to the local display number
docker run -d --user $(id -u):$(id -g) -e DISPLAY=$DISPLAY -e XAUTHORITY=/headless/.xauthority -v $XAUTH:/headless/.xauthority:rw -v $XSOCK:/tmp/.X11-unix:rw -v $DESIGNS:/foss/designs:rw foss-asic-tools:alpha

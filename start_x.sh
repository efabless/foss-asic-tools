#!/bin/bash

# SET YOU DESIGN PATH RIGHT!
if [ -z ${DESIGNS+z} ]; then
        DESIGNS=`realpath "$HOME/eda/designs"`
fi

PARAMS=""
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	echo "Auto detected Linux"
	# Senseful defaults (uses XAUTHORITY Shell variable if set, or the default .Xauthority -file in the caller home directory)
	if [ -z ${XAUTHORITY+z} ]; then
		if [ -f "~/.Xauthority" ]; then
			XAUTH="~/.Xauthority"
		else
			echo "Xauthority could not be found. Please set manually!"
			exit 1
		fi
	else
		XAUTH=$XAUTHORITY
	fi
	PARAMS = "$PARAMS -v $XAUTH:/headless/.xauthority:rw -e XAUTHORITY=/headless/.xauthority"
	# Should also be a senseful default
	if [ -z ${XSOCK+z} ]; then
                if [ -f "/tmp/.X11-unix" ]; then
			XSOCK="/tmp/.X11-unix"
                else
                        echo "X socket could not be found. Please set manually!"
                        exit 1
                fi
	fi
	PARAMS = "$PARAMS -v $XSOCK:/tmp/.X11-unix:rw"
        if [ -z ${DISP+z} ]; then
		if [ -z ${DISPLAY+z} ]; then
			echo "No DISPLAY set"
			exit 1
		else
	                DISP=$DISPLAY
		fi
        fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
	if [ -z ${DISP+z} ]; then
        	DISP="host.docker.internal:0"
	fi
else
        echo "Not setup for $OSTYPE"
	exit 1
fi


# Finally, run the container, sets DISPLAY to the local display number
docker run -d --user $(id -u):$(id -g) -e DISPLAY=$DISP -v $DESIGNS:/foss/designs:rw $PARAMS foss-asic-tools:alpha

#!/bin/bash

docker run --tty -p 80:80 --user $(id -u):$(id -g) -v $DESIGNS:/foss/designs -e VNC_RESOLUTION=1920x1080 foss-asic-tools:eta

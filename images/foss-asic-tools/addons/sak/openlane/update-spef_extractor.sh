#!/bin/sh
git clone git@github.com:The-OpenROAD-Project/OpenLane.git
cd OpenLane
git checkout 0a5afc3
\cp -a ./scripts/spef_extractor ../
cd ..
\rm -rf OpenLane

# IIC-OSIC-TOOLS Release Notes

This document summarizes the most important changes of the individual releases of the `IIC-OSIC-TOOLS` Docker container.

## 2023.02

* Fix noiseless SKY130 resistors (`ngspice-39` plus setting a proper flag in `.spiceinit`)
* Harmonize shell script text (using [INFO] and [ERROR] like in other scripts)
* Improve the IIC-PEX script
* Fix `klayout` error message ".lyp not found"
* Update various tool versions

## 2023.01

* Added packages: `fusesoc`, `jupyterlab`, `edalize`, `surf` (browser)
* Added support to run images for multiple users, implemented scripts for starting and stopping multiple instances
* Removed packages: `firefox`
* Update base OS (Ubuntu) to 22.04 LTS
* Update various tool versions
* Fix screen lockup (timeout due to `light-greeter`) in VNC mode.
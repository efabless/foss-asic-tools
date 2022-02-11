# FOSS-ASIC-TOOLS 
FOSS-ASIC-TOOLS is all in one container for SKY130 based design both Analog and Digital. Below is a list of the current tools already installed and ready to use.

| Name                      | Repository  | Version                                   |
|---------------------------|-------------|-------------------------------------------|
| base                      | centos7            | alpha                                     |
| magic                     | https://github.com/RTimothyEdwards/magic            | 6ecd077ab4e8a7b6ccd8922954cd56862a8d4c05  |
| klayout                   | https://github.com/KLayout/klayout            | d764adb1016f74d3e9cc8059cb183f5fc29b2a25  |
| skywater-pdk              | https://github.com/google/skywater-pdk            | f70d8ca46961ff92719d8870a18a076370b85f6c  |
| open_pdks                 | https://github.com/RTimothyEdwards/open_pdks            | 7519dfb04400f224f140749cda44ee7de6f5e095  |
| gtkwave                   | https://github.com/gtkwave/gtkwave            | 48c6409ed001f28eae9dc5fe87bb0b6b1a7c1217  |
| iverilog                  | https://github.com/steveicarus/iverilog            | 771d02bee1fe9faa21619ea83ddbba2cc9858f96  |
| netgen                    | https://github.com/RTimothyEdwards/netgen            | bfb01e032f668c09ff43e889f35d611ef0e4a317  |
| riscv-gnu-toolchain-rv32i | https://github.com/riscv-collab/riscv-gnu-toolchain            | 75b82e1f0b4fc8537305da7e5c6059cb8c73d54f  |
| openlane                  | https://github.com/The-OpenROAD-Project/OpenLane            | 2022.02.08_01.48.52                       |
| gaw3-xschem               | https://github.com/StefanSchippers/xschem-gaw            | a3239fdcc700e7b33331051eb22f47904112e849  |
| ngscope                   | https://sourceforge.net/projects/ngscope/files/rel_0_9/            | 0.9.5                                     |
| ngspice                   | https://github.com/ngspice/ngspice            | 1a6a9e6bb60ad8d07ecbfb3f35dea22379fb73e9  |
| xschem                    | https://github.com/StefanSchippers/xschem            | a24fbc36450205bae9e62c7dcc2bb61778aa0316  |
| xyce                      | https://github.com/Xyce/Xyce            | 94f506b8a8c8415d7e76d63b5ef78c1f2fc3a899  |
| covered                   | https://github.com/Manarabdelaty/verilog-covered            | 93bee2e0d89c1beb5943a329109dcf24d59498e6  |
| irsim                     | https://github.com/RTimothyEdwards/irsim            | 3813495e55a21a024e62e21bd6993fac068a61b9  |
| opensta                   | https://github.com/The-OpenROAD-Project/OpenSTA            | 8627c6826d752ed864faafb71461d3c24ae66655  |



### For Designers
Go the the Quick Launch instructions to get going. The container comes with project examples onboard.

### For Developers
FOSS-Tools Manager - building a docker container from s pecific set of commit ID for every tool on the list (receipe)

## Quick Launch

Download and install Docker for your operating system
- [Linux](https://hub.docker.com/search?q=&type=edition&offering=community&operating_system=linux&utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header) ||  [Windows](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header) || [Mac with Intel Chip](https://desktop.docker.com/mac/main/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header) || [Mac with Apple Chip](https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header)
```
cd $HOME
mkdir my-local-design-files
export DESIGNS=$HOME/my-local-design-files
docker pull efabless/foss-asic-tools:latest
docker run -it -p 80:80 --user $(id -u):$(id -g) -v $DESIGNS:/foss/designs efabless/foss-asic-tools:latest bash
```
- Open your browser of choice and go to https://localhost when asked for a password use "abc123" (default)
- [Watch this 5min video](https://youtu.be/EP3ozAtTQDw) to kickstart your analog project (Draft - more detailed on is coming)

## Prerequisites

- [docker](https://docs.docker.com/engine/install/)
- python3
- python virtualenv

  - `pip3 install virtualenv`

  - Setup the venv:
    ```
    virtualenv -p python3 venv
    source venv/bin/activate
    pip3 install -r requirements.txt
    ```

## Installation and Update

- Using a recipe csv file
  ```
  python3 run.py recipe --csv recipe.csv
  ```
- Buidling an individual image
  ```
  python3 run.py build openlane
  ```
- Updating an individual image
  - Run:
    ```
    python3 run.py update open_pdks
    ```
  - You will be prompted with:
    ```
    A new commit for (open_pdks) is available:
    44c13e2256d5907090d6a2a62d9b9f8ddf23758d
    Would you like to update? (y/N)
    ```
- Updating all images in a given recipe file
    ```
    python3 run.py recipe --csv ./recipes/recipe.csv --update-reference
    ```
    
## Setting Screen Resolution and Custom Password:
```
docker run -it -p 80:80 --user $(id -u):$(id -g) -v $DESIGNS:/foss/designs -e VNC_PW=<your password> -e VNC_RESOLUTION=1920x1080 efabless/foss-asic-tools:beta bash
```

## Notes

- Images are under images directory
- Versions in recipe file overwrite the image version
- The images are tagged `<name>:<version>`
- The final image is called `foss-tools:<tag>`, so if you want to run multiple recipes modify the tag of `foss-tools`

## Todo

- Dependancies handling
- Differentiate between git and non git based packages


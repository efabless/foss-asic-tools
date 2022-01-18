# FOSS-TOOLS

FOSS-Tools Manager - building a docker container from s pecific set of commit ID for every tool on the list (receipe)

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

## Installation and Running

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
## Quick Launch:

Download and install Docker for your operating system
- [Windows](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header)
- [Linux](https://hub.docker.com/search?q=&type=edition&offering=community&operating_system=linux&utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header)
- [Mac - Intel Chip](https://desktop.docker.com/mac/main/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header)
- [Mac - Apple Chip](https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=header)
```
  export DESIGNS=<host path for designs>
  docker pull efabless/foss-asic-tools:alpha
  docker run -it -p 80:80 --user 0  -v $DESIGNS:/foss/designs efabless/foss-asic-tools:alpha bash
```
- Open your browser of choice and go to https://localhost when asked for a password use abc123 which is the default.

## Setting Screen Resolution and Custom Password:
```
docker run -it -p 80:80 --user 0  \
-v $DESIGNS:/foss/designs \
-e VNC_PW=<your password> \
-e VNC_RESOLUTION=1920x1080 \
efabless/foss-asic-tools:alpha bash
```
## Notes

- Images are under images directory
- Versions in recipe file overwrite the image version
- The images are tagged `<name>:<version>`
- The final image is called `foss-tools:<tag>`, so if you want to run multiple recipes modify the tag of `foss-tools`

## Todo

- Dependancies handling
- Differentiate between git and non git based packages


# FOSS-ASIC-TOOLS 
FOSS-ASIC-TOOLS is all in one container for SKY130 based design both Analog and Digital. Below is a list of the current tools already installed and ready to use.

## Quick Launch for Designers

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

## Details for Developers and Contributor

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


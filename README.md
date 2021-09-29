# FOSS-TOOLS

FOSS-Tools Manager

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
- Running foss-tools:
  ```
  docker run -it -p 80:80 foss-tools:alpha
  ```

## Notes

- Images are under images directory
- Versions in recipe file overwrite the image version
- The images are tagged `<name>:<version>`
- The final image is called `foss-tools:<tag>`, so if you want to run
    multiple recipes modify the tag of `foss-tools`

## Todo

- Dependancies handling
- Differentiate between git and non git based packages


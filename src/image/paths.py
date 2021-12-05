#!/usr/bin/env python3

import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
IMAGES_PATH = "../../images/"


def getAllImagesPath():
    packages_dir = os.path.abspath(
        os.path.join(SCRIPT_DIR, IMAGES_PATH))
    dirs = os.listdir(packages_dir)
    dirs_not_hidden = [f for f in dirs if not f.startswith('.')]
    full_dirs_path = [os.path.join(packages_dir, f) for f in dirs_not_hidden]
    dirs_not_hidden_folders = [f for f in full_dirs_path if os.path.isdir(f)]
    return dirs_not_hidden_folders


def getImagePath(package_name):
    path = os.path.join(SCRIPT_DIR, IMAGES_PATH, package_name)
    return path


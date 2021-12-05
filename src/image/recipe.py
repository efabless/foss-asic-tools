#!/usr/bin/env python3

from .paths import getImagePath
import json
import csv
from .image import Image


def parseRecipeDict(recipe_dict):
    images = []
    for item in recipe_dict:
        name = item
        version = recipe_dict[name]["version"]
        pkg_path = getImagePath(name)
        image = Image.createFromPath(pkg_path)
        image.setVersion(version)
        images.append(image)

    return images


def readJsonFile(recipe_file):
    f = open(recipe_file)
    json_dict = json.load(f)
    f.close()

    return json_dict


def tableToDict(table):
    dict = {}
    for row in table:
        name = row[0]
        version = row[1]

        entry_dict = {}
        entry_dict["version"] = version
        dict[name] = entry_dict

    return dict

def parseCsvFile(recipe_file):
    rows = []
    with open(recipe_file, 'r') as csvfile:
        csvreader = csv.reader(csvfile)
        next(csvreader)
        for row in csvreader:
            rows.append(row)

    dict = tableToDict(rows)
    return dict

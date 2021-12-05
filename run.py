#!/usr/bin/env python3

import argparse
from src.image import recipe
from src.image.image import Image
from src.docker_builder.docker_builder import DockerBuilder
from src.image import paths as p

def buildImages(paths):
    builder = DockerBuilder()
    images = []
    for image_path in paths:
        image = Image.createFromPath(image_path)
        image.build_status = builder.build(image)
        images.append(image)

    return images

def build(args):
    all_flag = args.all
    paths = []

    if (all_flag == True):
        paths = p.getAllImagesPath()
    else:
        images_name = args.images
        for image_name in images_name:
            paths.append(p.getImagePath(image_name))

    images = buildImages(paths)
    for image in images:
        print("Image: " + image.name + " " + str(image.build_status))


def update(args):
    updateFlag = args.yes
    all_flag = args.all
    paths = []

    if (all_flag == True):
        paths = p.getAllImagesPath()
    else:
        images = args.images
        for image in images:
            paths.append(p.getImagePath(image))

    for path in paths:
        image = Image.createFromPath(path)
        image.update(updateFlag)


def handleRecipe(args):
    json_file = args.json
    csv_file = args.csv
    update = args.update
    dict = None

    if json_file != None:
        dict = recipe.readJsonFile(json_file)
    elif csv_file != None:
        dict = recipe.parseCsvFile(csv_file)

    images = recipe.parseRecipeDict(dict)
    if update == True:
        csv = "Name,Version\n"
        for image in images:
            image.update(updateFlag=True)
            csv += f"{image.name},{image.version}\n"
        with open(csv_file, "w") as file:
            file.writelines(csv)
    else:
        builder = DockerBuilder()
        for image in images:
            image.build_status = builder.build(image)

        for image in images:
            status = "Fail"
            if image.build_status == True:
                status = "Success"
            print("Image | {:^30} | {:10} ".format(image.name, status))


parser = argparse.ArgumentParser(
    description="I don't know how to describe this yet"
)
subparsers = parser.add_subparsers()
build_subparser = subparsers.add_parser("build",
                                        help="build ")
build_subparser.add_argument("--all", action="store_true")
build_subparser.add_argument("images", nargs='*', type=str)
build_subparser.set_defaults(func=build)

update_subparser = subparsers.add_parser("update",
                                         help="update")
update_subparser.add_argument("--all", action="store_true")
update_subparser.add_argument("-y", "--yes", action="store_true")
update_subparser.add_argument("images", nargs='*', type=str)
update_subparser.set_defaults(func=update)

recipe_subparser = subparsers.add_parser("recipe",
                                         help="recipe ")
recipe_subparser.add_argument("--json", type=str)
recipe_subparser.add_argument("--csv", type=str)
recipe_subparser.add_argument("--update", action="store_true")
recipe_subparser.set_defaults(func=handleRecipe)

args = parser.parse_args()
args.func(args)

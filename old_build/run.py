#!/usr/bin/env python3

import argparse
from src.image import recipe
from src.image.image import Image
from src.docker_builder.docker_builder import DockerBuilder
from src.image import paths as p


class _HelpAction(argparse._HelpAction):
    def __call__(self, parser, namespace, values, option_string=None):
        parser.print_help()

        # retrieve subparsers from parser
        subparsers_actions = [
            action for action in parser._actions
            if isinstance(action, argparse._SubParsersAction)
        ]
        # there will probably only be one subparser_action,
        # but better save than sorry
        for subparsers_action in subparsers_actions:
            # get all subparsers and print help
            for choice, subparser in subparsers_action.choices.items():
                print("Subparser '{}'".format(choice))
                print(subparser.format_help())

        parser.exit()


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
    update = args.update_reference
    dictionary = None

    if json_file != None:
        dictionary = recipe.readJsonFile(json_file)
    elif csv_file != None:
        dictionary = recipe.parseCsvFile(csv_file)

    images = recipe.parseRecipeDict(dictionary)
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
    description="A tool that builds and updates a set of docker images",
    add_help=False)

parser.add_argument("-h",
                    "--help",
                    action=_HelpAction,
                    help="show this help message and exit")

subparsers = parser.add_subparsers()

build_subparser = subparsers.add_parser("build",
                                        help="build one or more images")
build_subparser.add_argument("--all", action="store_true")
build_subparser.add_argument("images", nargs='+', type=str)
build_subparser.set_defaults(func=build)

update_subparser = subparsers.add_parser("update",
                                         help="update one or more image")
update_subparser.add_argument("--all", action="store_true")
update_subparser.add_argument("-y", "--yes", action="store_true")
update_subparser.add_argument("images", nargs='+', type=str)
update_subparser.set_defaults(func=update)

recipe_subparser = subparsers.add_parser("recipe",
                                         help="build images in a recipe file")
recipe_group = recipe_subparser.add_mutually_exclusive_group(required=True)
recipe_group.add_argument("--json", type=str)
recipe_group.add_argument("--csv", type=str)
recipe_subparser.add_argument(
    "--update-reference",
    help=
    "update reference in a recipe file. Run without --update-reference to update the tool(s) afterwards",
    action="store_true")
recipe_subparser.set_defaults(func=handleRecipe)

args = parser.parse_args()
args.func(args)

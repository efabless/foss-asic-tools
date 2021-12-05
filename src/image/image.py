#!/usr/bin/python3

import os
import json
import git
import json


class Image():
    def __init__(self, name, path, args, json_file, meta_data):
        self.name = name
        self.path = path
        self.args = args
        self.url = self.args['REPO_URL']
        self.json_file = json_file
        self.meta_data = meta_data
        self.version = self.args["REPO_COMMIT"]
        self.build_status = False


    @classmethod
    def createFromPath(cls, path):
        JSON_FILE = "info.json"
        json_file = os.path.join(path, JSON_FILE)

        return cls.createFromJSON(json_file)

    @classmethod
    def createFromJSON(cls, json_file):
        f = open(json_file)
        meta_data = json.load(f)
        f.close()

        args = meta_data['args']
        name = args['NAME']

        path = os.path.dirname(os.path.abspath(json_file))

        return cls(
            name=name,
            path=path,
            args=args,
            json_file=json_file,
            meta_data=meta_data
        )


    def getLatestVersion(self):
        url = self.url
        g = git.cmd.Git()
        response = g.ls_remote(url, 'HEAD')
        latest_version = response.split()[0]

        return latest_version


    def updatePrompt(self, new_version):
        print("A new commit for (%s) is available:\n%s" % (self.name, new_version))
        user_response = input("Would you like to update? (y/N) ").lower()

        if (user_response == 'y'):
            response = True
        else:
            response = False

        return response


    def update(self, updateFlag=False):
        current_version = self.version
        new_version = self.getLatestVersion()

        if (new_version != current_version):
            if (updateFlag == True):
                self.commitVersion(new_version)
            else:
                response = self.updatePrompt(new_version)
                if (response == True):
                    self.commitVersion(new_version)
                    print("New version commited!")
        else:
           print("Latest version for (%s) synced.\n"
                 "Run install to install it.\n"
                 "Nothing to be done." % self.name)


    def commitVersion(self, new_version):
        self.version = new_version

        self.meta_data['args']['REPO_COMMIT'] = new_version

        with open(self.json_file, 'w') as f:
            f.write(json.dumps(self.meta_data, indent=4))



    def setVersion(self, version):
        old_version = self.version
        if (old_version != version):
            self.commitVersion(version)


#!/usr/bin/python3

import docker
import time
import logging
import re


class DockerBuilder():
    def __init__(self):
        self.rm = True
        self.client = self.createClient()
        self.logger = logging.getLogger("DockerBuilder logger")
        self.configLogger()

    def createClient(self):
        client = docker.from_env()
        return client

    def configLogger(self):
        self.logger.setLevel(logging.INFO)
        handler = logging.StreamHandler()
        formatter = logging.Formatter(
            fmt='[%(levelname)s %(asctime)s] %(message)s', datefmt='%d-%b-%y %H:%M:%S'
        )
        handler.setFormatter(formatter)
        self.logger.addHandler(handler)

    def build(self, target):
        self.logger.info("Building %s", target.name)
        default_tag = target.name + ":" + "latest"
        version_tag = target.name + ":" + target.version
        build_status = False
        try:
            response = self.client.api.build(
                path=target.path,
                rm=self.rm,
                tag=version_tag,
                buildargs=target.args,
                decode=True
            )
            for line in response:
                self.printResponse(line, target.name)

            self.client.api.tag(version_tag, default_tag)
            build_status = True
        except docker.errors.APIError as e:
            self.logger.error(e)
            time.sleep(2)

        return build_status

    def printResponse(self, response, name):
        ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
        if 'stream' in response:
            for line in response['stream'].splitlines():
                line = line.rstrip()
                line = ansi_escape.sub('', line)
                if line != '\n' and line != '':
                    self.logger.info("[" + name + "] :: " + line.rstrip())
        elif 'error' in response:
            raise docker.errors.APIError(response['error'])

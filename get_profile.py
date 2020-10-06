#!/usr/bin/env python3
import os.path
import configparser
config = configparser.ConfigParser()
config.read(os.path.expanduser('~/.mozilla/firefox/profiles.ini'))
for section in config.sections():
    if section.startswith("Install"):
        s = config[section]
        if "Default" in s:
            print(s["Default"])
            break

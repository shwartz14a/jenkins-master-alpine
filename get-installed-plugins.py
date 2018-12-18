#!/usr/bin/env python

import requests
import os
import json

JENKINS_USER = "user"
JENKINS_PASSWORD = "password"

response = requests.get('http://JENKINS_USER:JENKINS_PASSWORD@localhost:8080/pluginManager/api/json?depth=1&?xpath=/*/*shortName|/*/*/version')
data = response.json()['plugins']

for plugin in data:
    print "%s:%s" % (plugin["shortName"], plugin["version"])



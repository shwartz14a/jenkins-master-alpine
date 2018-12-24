#!/usr/bin/env python

from requests.auth import HTTPBasicAuth
import requests
import os

auth = HTTPBasicAuth('user', 'password')
response = requests.get('http://172.28.128.1/pluginManager/api/json?depth=1&?xpath=/*/*shortName|/*/*/version', auth=auth)
data = response.json()['plugins']

for plugin in data:
    print "%s:%s" % (plugin["shortName"], plugin["version"])



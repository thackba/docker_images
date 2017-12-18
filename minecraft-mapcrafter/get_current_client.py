import json
import os
import urllib
import urllib2

versions_manifest_response = urllib2.urlopen('https://launchermeta.mojang.com/mc/game/version_manifest.json')
versions_manifest_json = json.loads(versions_manifest_response.read())

target_version = os.environ['MINECRAFT_VERSION']

version_manifest_url = ""
version_client_url = ""

for version_manifest_part in versions_manifest_json['versions']:
    if version_manifest_part["type"] == "release" and version_manifest_part["id"] == target_version:
        version_manifest_url = version_manifest_part["url"]

if len(version_manifest_url) > 0:
    version_response = urllib2.urlopen(version_manifest_url)
    version_json = json.loads(version_response.read())
    version_client_url = version_json["downloads"]["client"]["url"]

if len(version_client_url) > 0:
    urllib.urlretrieve(version_client_url, '/minecraft_client.jar')

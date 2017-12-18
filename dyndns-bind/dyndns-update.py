#!/usr/bin/python

import hashlib
import json
import subprocess
import tempfile
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path

PORT_NUMBER = 8080

SETTINGS = {}
SETTINGS_FILE = "/data/settings.json"

PARAM_DOMAIN = 'domain'
PARAM_USERNAME = 'username'
PARAM_PASSWORD = 'password'
PARAM_IPV4 = 'ip4addr'
PARAM_IPV6 = 'ip6addr'

JSON_ROOT = 'sites'
JSON_ZONE = 'zone'
JSON_HOST = 'host'
JSON_USERNAME = 'username'
JSON_PASSWORD_KEY = 'password_key'
JSON_PASSWORD_SALT = 'password_salt'


class DynDNSHandler(BaseHTTPRequestHandler):
    # log requests to the console
    # do NOT log query parameter to console
    def log_request(self, code='-', size='-'):
        path_parts = self.requestline.split('?')
        parameters = self.generate_parameters(path_parts)
        if PARAM_PASSWORD in parameters:
            del parameters[PARAM_PASSWORD]
        self.log_message('"%s" %s %s %s', path_parts[0], str(code), str(size), parameters)

    # Handler for the GET requests
    def do_GET(self):
        parts = self.path.split('?')
        if parts[0] == '/update':
            params = self.generate_parameters(parts)
            if self.check_parameters(params) and self.validate_parameters(params):
                self.update_ip(params, SETTINGS[JSON_ROOT][params[PARAM_DOMAIN]])
            else:
                self.send_error(400, 'Bad Request: query parameters are missing or wrong')
        else:
            self.send_error(404, 'File Not Found: %s' % parts[0])
        return

    def generate_parameters(self, path_array):
        parameters = {}
        if len(path_array) > 1:
            query_parameters = path_array[1].split('&')
            for query_parameter in query_parameters:
                splitted_parameter = query_parameter.split('=')
                parameters[splitted_parameter[0]] = splitted_parameter[1]
        return parameters

    def check_parameters(self, parameters):
        return PARAM_DOMAIN in parameters and \
               PARAM_USERNAME in parameters and \
               PARAM_PASSWORD in parameters and \
               parameters[PARAM_DOMAIN] in SETTINGS[JSON_ROOT]

    def validate_parameters(self, parameters):
        site = SETTINGS[JSON_ROOT][parameters[PARAM_DOMAIN]]
        has_correct_username = site[JSON_USERNAME] == parameters[PARAM_USERNAME]
        password_hash = self.build_hash(site[JSON_PASSWORD_SALT], parameters[PARAM_PASSWORD])
        has_correct_password = site[JSON_PASSWORD_KEY] == password_hash
        return has_correct_username and has_correct_password

    def update_ip(self, parameters, setting):
        if PARAM_IPV4 in parameters or PARAM_IPV6 in parameters:
            with tempfile.NamedTemporaryFile() as temp:
                temp.write(('server localhost\nzone %s.\n' % (setting[JSON_ZONE])).encode('utf-8'))
                temp.write(('update delete %s.%s.\n' % (setting[JSON_HOST], setting[JSON_ZONE])).encode('utf-8'))
                if PARAM_IPV4 in parameters:
                    temp.write(('update add %s.%s. 60 A %s\n' % (
                        setting[JSON_HOST], setting[JSON_ZONE], parameters[PARAM_IPV4])).encode('utf-8'))
                if PARAM_IPV6 in parameters:
                    temp.write(('update add %s.%s. 60 AAAA %s\n' % (
                        setting[JSON_HOST], setting[JSON_ZONE], parameters[PARAM_IPV6])).encode('utf-8'))
                temp.write('send\n'.encode('utf-8'))
                temp.seek(0)
                # call nsupdate
                try:
                    subprocess.check_call(["nsupdate", "-k", "/data/dyndns.key", temp.name])
                    self.send_content('IP updated!')
                except subprocess.CalledProcessError:
                    self.send_content('IP NOT updated!')


    def build_hash(self, salt, password):
        hash_builder = hashlib.sha512()
        hash_builder.update(salt.encode('utf-8'))
        hash_builder.update(password.encode('utf-8'))
        return hash_builder.hexdigest()

    def send_content(self, content):
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()
        self.wfile.write(content.encode('utf-8'))


# end of class

try:
    settings_file = "/example_settings.json"
    if Path(SETTINGS_FILE).is_file():
        settings_file = SETTINGS_FILE
    with open(settings_file) as data_file:
        SETTINGS = json.load(data_file)
    # Create a web server and define the handler to manage the incoming request
    server = HTTPServer(('', PORT_NUMBER), DynDNSHandler)
    print('Started httpserver on port', PORT_NUMBER)
    print('Known dyndns domains', SETTINGS[JSON_ROOT].keys())

    # Wait forever for incoming http requests
    server.serve_forever()

except KeyboardInterrupt:
    print('^C received, shutting down the web server')
    server.socket.close()

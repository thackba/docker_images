#!/usr/bin/python

import hashlib
import random
import sys


def build_hash(salt, password):
    hash_builder = hashlib.sha512()
    hash_builder.update(salt.encode('utf-8'))
    hash_builder.update(password.encode('utf-8'))
    return hash_builder.hexdigest()


if len(sys.argv) > 1:
    password = sys.argv[1]
else:
    password = 'password'

print(' password      : ', password, '\n')
salt = random.getrandbits(512)
salt_string = "%032x" % salt
print('"password_salt": "' + salt_string + '",')
password_hash = build_hash(salt_string, password)
print('"password_key":  "' + password_hash + '"')

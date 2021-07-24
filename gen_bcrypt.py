#!/usr/bin/python3

import crypt,getpass 

username = input("Enter user's name:")

bcrypt_hash = crypt.crypt(getpass.getpass(), crypt.mksalt(crypt.METHOD_SHA512))

string = ":18215:0:99999:7:::"

record = username + ":" + bcrypt_hash + string

f = open(username + ".hash", "w")
f.write(record + "\n")
f.close()

#!/bin/bash

openssl genrsa 2048 > server.key

openssl req -new -key server.key <<EOF > server.csr
JP
Tokyo
Neet Town
Neet Company
Neet Section




EOF

openssl x509 -days 3650 -req -signkey server.key < server.csr > server.crt

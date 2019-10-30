#!/bin/bash

#############################3
# nginx.dev.com
#############################3
openssl genrsa 2048 > server.key

openssl req -new -key server.key <<EOF > server.csr
JP
Tokyo
Test
Test
Test
nginx.dev.com



EOF

openssl x509 -days 3650 -req -signkey server.key < server.csr > server.crt

#############################3
# *.dev.com
#############################3
openssl genrsa 2048 > server_wild.key

openssl req -new -key server_wild.key <<EOF > server_wild.csr
JP
Tokyo
Test
Test
Test
*.dev.com



EOF

openssl x509 -days 3650 -req -signkey server_wild.key < server_wild.csr > server_wild.crt

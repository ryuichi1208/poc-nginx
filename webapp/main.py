#!/usr/local/bin/python3
# coding: utf-8

import collections
import datetime
import os
import socket
import sys
import functools

from flask import Flask, request, make_response, jsonify
from multiprocessing import Pool, Process, cpu_count

app = Flask(__name__)

@app.route('/_info', methods=['GET'])
def index():
    return jsonify(
        {
            "headers" : dict(request.headers),
            "host": {
                "name" : os.uname()[1],
                "ip" : socket.gethostbyname(socket.gethostname()),
                "ppid" : os.getppid(),
                "pid" : os.getpid()
            }
        }
    )

@app.route('/status/<int:status_code>', methods=['GET'])
def return_http_status(status_code):
    status_list = {
        200: "OK",
        400: "Bad Request",
        404: "Not Found",
        500: "Internal Server Error"
    }

    try:
        status_list[status_code]
    except KeyError:
        return jsonify({"status" : status_list[404]}), 404

    return jsonify({"status" : status_list[status_code]}), status_code

if __name__ == '__main__':
    CRUD_JSON_AS_ASCII = os.getenv('JSON_AS_ASCII') or False
    CRUD_FLASK_DEBUG_MODE = os.getenv('FLASK_DEBUG_MODE') or True
    CRUD_FLASK_IP_ADDR = os.getenv('FLASK_IP_ADDR') or "0.0.0.0"
    CRUD_FLASK_PORT = os.getenv('FLASK_PORE_NUM') or 5000

    app.config['JSON_AS_ASCII'] = CRUD_JSON_AS_ASCII
    app.debug = CRUD_FLASK_DEBUG_MODE
    app.run(host=CRUD_FLASK_IP_ADDR, port=CRUD_FLASK_PORT)

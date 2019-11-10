#!/usr/local/bin/python3
# coding: utf-8

import collections
import datetime
import os
import socket
import sys
import time
import functools
import itertools
import requests
import pathlib
import werkzeug
import redis

from flask import Flask, request, make_response, jsonify, render_template
from multiprocessing import Pool, Process, cpu_count
# from werkzeug.exception import HTTPException

app = Flask(__name__)
# app.config['SECRET_KEY'] = ""
# app.config['UPLOAD_FOLDER'] = ""


@app.route("/", methods=["GET"])
def index():
    return jsonify(
        {
            "headers": dict(request.headers),
            "host": {
                "name": os.uname()[1],
                "ip": socket.gethostbyname(socket.gethostname()),
                "ppid": os.getppid(),
                "pid": os.getpid(),
                "date": str(datetime.datetime.today())[:-7]
            },
        }
    )


@app.route("/test/status/<int:status_code>", methods=["GET"])
def return_http_status(status_code):
    status_list = {
        200: "OK",
        400: "Bad Request",
        404: "Not Found",
        429: "Too Many Requests",
        500: "Internal Server Error",
    }

    try:
        status_list[status_code]
    except KeyError:
        return jsonify({"status": status_list[404]}), 404

    return jsonify({"status": status_list[status_code]}), status_code


@app.route("/test/sleep", methods=["GET", "POST"])
def sleep():
    if request.method == "GET":
        time.sleep(int(request.args.get("st", 10)))
        return request.method + "\n"
    else:
        time.sleep(int(request.form["st"]))
        return "POST"


@app.route("/test/static/<string:filename>", methods=["GET"])
def return_static(filename):
    return render_template(filename + ".html", message=filename)


@app.route("/test/stress")
def do_stress_test():
    L = list(itertools.permutations([i ** 128 for i in range(128)]))
    return "200"

def get_redis_connnetc_pool(serv:str, port:int=6379, db:int=0):
    pool = redis.ConnectionPool(host=serv, port=port, db=db)
    return redis.StricRedis(connection_pool=pool)


@app.route("/test/redis", methods=["GET", "POST"])
def redis_cli():
    get_redis_connnetc_pool("redis001")


@app.errorhandler(404)
def error_handler(error):
    response = jsonify({"message": "not found", "status_code": "4000"})
    return response, error.code


# @app.errorhandler(HttpException)
# def handle_http_exception(error):
#     return error.get_response()


if __name__ == "__main__":
    CRUD_JSON_AS_ASCII = os.getenv("JSON_AS_ASCII") or False
    CRUD_FLASK_DEBUG_MODE = os.getenv("FLASK_DEBUG_MODE") or True
    CRUD_FLASK_IP_ADDR = os.getenv("FLASK_IP_ADDR") or "0.0.0.0"
    CRUD_FLASK_PORT = os.getenv("FLASK_PORE_NUM") or 5000

    app.config["JSON_AS_ASCII"] = CRUD_JSON_AS_ASCII
    app.debug = CRUD_FLASK_DEBUG_MODE
    app.run(host=CRUD_FLASK_IP_ADDR, port=CRUD_FLASK_PORT)

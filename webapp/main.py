#!/usr/local/bin/python3
# coding: utf-8

import collections
import datetime
import os
import sys
import functools

from flask import Flask, request, make_response, jsonify
from multiprocessing import Pool, Process, cpu_count
from module import github_trend
from module import qiita_trend

app = Flask(__name__)

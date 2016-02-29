#!/usr/bin/python
#**************************************************************************************************
# RESTful Flask API
# Eugene Kolo | eugenekolo.com
# 
# `GET /api/{}`
# `POST /api/{}`
#
# TODO: Install a session manager
# TODO: Write a setup.py
# TODO: Examine grequests
# TODO: Get working with sqlite3
#**************************************************************************************************

import traceback, os, posixpath
import argparse, sqlite3, pprint

from flask import Flask, request, json, session
from flask.ext.cors import CORS
from flask_limiter import Limiter

from apihelper import json_dump, SqliteSession

#**********************************************************
# Server setup
#**********************************************************
DELAY = True
app = Flask(__name__)
with open('key.secret', 'r') as secret_key:
    app.secret_key = secret_key.read()

cors = CORS(app)

# Can add pre(before) or post(after) hooks here...
# def exposer_headers(response):
#    response.headers.add('Access-Control-Expose-Headers', 'Content-Dispositions, Content-Length')
# apps.after_request(expose_headers)
# TODO(eugenek): https://github.com/maxcountryman/flask-login

# Can add rate limiting here...
# limiter = Limiter(app)
# if (DELAY):
#    limit = limiter.shared_limit("...")
#    pass


@app.route('/priv/login', methods=['POST'])
# @limit
def post_login():
    """
    Attempts login of the user
    POST /priv/login
    Data: {
           "username": "eugene@eugenekolo.com",
           "password": "love"
           }
    """
    try:
        payload = json.loads(request.get_data())
        username = payload['username']
        password = payload['password']
        return json_dump({'hello': 'from post_login'})
    except Exception:
        print(traceback.format_exc())
        return "Error", 500

@app.route('/priv/logout', methods=['POST'])
def post_logout():
    session.clear()
    return "Logged out homie", 200

@app.route('/priv/message/<int:idx>', methods=['GET'])
def get_message(idx):
    try:
        return json_dump({'hello': 'from get_message'})
    except Exception:
        print(traceback.format_exc())
        return "Error", 500

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--debug', action='store_true', default=False,
        help='Enable debugging, default=False')
    parser.add_argument('-x', '--host', default='127.0.0.1', 
        help='The host to bind to, default=127.0.0.1')
    parser.add_argument('-p', '--port', type=int, default=5000,
        help='The port of the host to bind to, default=5000')
    args = parser.parse_args()

    app.run(debug=args.debug, host=args.host, port=args.port, threaded=True)
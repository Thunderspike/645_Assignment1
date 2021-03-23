import requests
from flask import Flask
import os

app = Flask(__name__)

CATTLE_BASIC_AUTH = os.getenv('CATTLE_BASIC_AUTH')
CATTLE_URL = os.getenv('CATTLE_URL')


@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/cattleurl')
def cattleurl():
    return CATTLE_URL


@app.route('/redeploy')
def redeploy():
    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': CATTLE_BASIC_AUTH
    }

    response = requests.post(CATTLE_URL, headers=headers, verify=False)
    return f'Response Code: {response.status_code}'

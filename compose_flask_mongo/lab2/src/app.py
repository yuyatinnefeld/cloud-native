import os

from pymongo import MongoClient
from flask import Flask, request, jsonify

from settings import MONGO_DB_INSTANCE_URL, ENVIRONMENT_DEBUG, ENVIRONMENT_PORT


application = Flask(__name__)
client = MongoClient(MONGO_DB_INSTANCE_URL)
db = client.user_account


@application.route('/')
def index():
    return {"hello":"world"}


@application.route('/users')
def users():
    _users = db.users.find()    
    item = {}
    data = []
    for user in _users:
        item = {
            'id': str(user['_id']),
            'name': user['name'],
            'address': user['address']
        }
        data.append(item)

    return jsonify(
        status=True,
        data=data
    )
    
@application.route('/users', methods=['POST'])
def create_user():
    data = request.get_json(force=True)
    item = {
        'name': data['name'],
        'address': data['address']
    }
    db.users.insert_one(item)

    return jsonify(
        status=True,
        message='To-do saved successfully!'
    ), 201

if __name__ == "__main__":
    application.run(host='0.0.0.0', port=ENVIRONMENT_PORT, debug=ENVIRONMENT_DEBUG)

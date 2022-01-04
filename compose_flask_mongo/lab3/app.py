from flask import Flask, request, jsonify
from pymongo import MongoClient

from settings import MONGO_HOST, MONGO_PORT, MONGO_DB_NAME, MONGO_DB_USERNAME, MONGO_DB_PASSWOR


app = Flask(__name__)


def get_db():
    client = MongoClient(
        host=MONGO_HOST,
        port=MONGO_PORT, 
        username=MONGO_DB_USERNAME, 
        password=MONGO_DB_PASSWOR,
        authSource="admin"
    )

    db = client[MONGO_DB_NAME]
    return db

@app.route('/')
def ping_server():
    return "Welcome to the world of users."


@app.route('/users')
def get_stored_users():
    db = get_db()
    _users = db.users.find()
    users = [{"name": user["name"], "address": user["address"]} for user in _users]
    return jsonify({"users": users})


@app.route('/users', methods=['POST'])
def create_user():
    data = request.get_json(force=True)
    user = {
        'name': data['name'],
        'address': data['address']
    }
    db = get_db()
    db.users.insert_one(user)

    return jsonify(
        status=True,
        message='User saved successfully!'
    ), 201


if __name__=='__main__':
    app.run(host="0.0.0.0", port=5000)
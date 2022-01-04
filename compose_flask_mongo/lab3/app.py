from flask import Flask, jsonify
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
def get_stored_animals():
    db = get_db()
    _users = db.users.find()
    users = [{"id": user["id"], "name": user["name"], "address": user["address"]} for user in _users]
    
    return jsonify({"users": users})

if __name__=='__main__':
    app.run(host="0.0.0.0", port=5000)
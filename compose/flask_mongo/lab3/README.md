# Flask + Mongo DB with docker-compose.yml

## Setup the Mongo DB Login Variables
```bash
vi settings.py
vi docker-compose.yml
```

## Create a db "user_account" and a collection (table) "users"
```bash
# create a inital db script
vi innit-db.js
```


## Create a Flask + Mongo Env

```bash
# create a Dockerfile
vi Dockerfile

# create a Flask + Mongo Container
docker-compose up

# call the flask site
curl -i http://127.0.0.1:5000
curl -i http://127.0.0.1:5000/users

# create 3 users
curl -i -H "Content-Type: application/json" -X POST -d '{"name": "golilla", "address": "banana paradis str 789"}' http://127.0.0.1:5000/users
curl -i -H "Content-Type: application/json" -X POST -d '{"name": "chihuahua", "address": "berlin"}' http://127.0.0.1:5000/users
curl -i -H "Content-Type: application/json" -X POST -d '{"name": "cat", "address": "post nyan nyan"}' http://127.0.0.1:5000/users
```
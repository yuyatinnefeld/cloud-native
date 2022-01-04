# Flask + Mongo DB with docker run

## Info
https://www.digitalocean.com/community/tutorials/how-to-set-up-flask-with-mongodb-and-docker

## Container
- flask container
- mongo DB container
- mongo Express UI container

## Setup MongoDB
```bash
# pull images
docker pull mongo
docker pull mongo-express

# create env vars
export NETWORK_NAME="mongo-network"
export MONGO_DB_USERNAME="admin"
export MONGO_DB_PASSWOR="password"
export MONGO_CONTAINER_NAME="mongodb"
export MONGO_EXPRESS_CONTAINER_NAME="mongo-express"

# create a new network for the 3 containers
docker network ls
docker network create ${NETWORK_NAME}
docker network ls

# create a mongo container
docker run -d \
    -p 27017:27017 \
    -e MONGO_INITDB_ROOT_USERNAME=${MONGO_DB_USERNAME} \
    -e MONGO_INITDB_ROOT_PASSWORD=${MONGO_DB_PASSWOR} \
    --name ${MONGO_CONTAINER_NAME} \
    --net ${NETWORK_NAME}\
    mongo

# check logs
docker logs ${MONGO_CONTAINER_NAME}

# create a mongo express container
docker run -d \
    -p 8081:8081 \
    -e ME_CONFIG_MONGODB_ADMINUSERNAME=${MONGO_DB_USERNAME} \
    -e ME_CONFIG_MONGODB_ADMINPASSWORD=${MONGO_DB_PASSWOR} \
    --net ${NETWORK_NAME} \
    --name ${MONGO_EXPRESS_CONTAINER_NAME} \
    -e ME_CONFIG_MONGODB_SERVER=${MONGO_CONTAINER_NAME} \
    mongo-express

docker logs ${MONGO_EXPRESS_CONTAINER_NAME}

# open the USL
localhost:8081
```

## create a db "user_account" and a table "users" in the Mongo Express GUI
- db = user_account
- table = users

## Test the Connection

```bash
# create a python venv
python3 -m venv venv
source venv/bin/activate

# install the mongo db client and flask package
pip install -r requirements.txt

# create a connection test script and insert data into the users table
vi src/conn_mongo_db.py
python src/conn_mongo_db.py

# checkt the URL
http://localhost:8081/db/user_account/users
```

## Create a Flask Service
```bash
vi src/app.py
export FLASK_APP=src/app.py
flask run

# open the URL
localhost:5000/users
curl -i http://127.0.0.1:5000/users

# create 3 users
curl -i -H "Content-Type: application/json" -X POST -d '{"name": "yt", "address": "cologne"}' http://127.0.0.1:5000/users
curl -i -H "Content-Type: application/json" -X POST -d '{"name": "mt", "address": "berlin"}' http://127.0.0.1:5000/users
curl -i -H "Content-Type: application/json" -X POST -d '{"name": "it", "address": "hamburg"}' http://127.0.0.1:5000/users
```
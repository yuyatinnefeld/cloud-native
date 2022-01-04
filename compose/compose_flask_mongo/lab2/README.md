# Flask + Mongo DB with docker-compose.yml

## Setup the Mongo DB
```bash
# set local env
export NETWORK_NAME="mongo-network"
export MONGO_DB_USERNAME="admin"
export MONGO_DB_PASSWOR="password"
export MONGO_CONTAINER_NAME="mongo"
export MONGO_EXPRESS_CONTAINER_NAME="mongo-express"

vi docker-compose.yml

# create a 2 containers, network is created automatically
docker-compose up
docker network ls

# open the USL
localhost:8081
```

## create a db "user_account" and a table "users" in the Mongo Express GUI
- databese = user_account
- collection (table) = users


## Test the Connection

```bash
# create a python venv
python3 -m venv venv
source venv/bin/activate

# install the mongo db client and flask package
pip install -r requirements.txt

# create a connection test script and insert data into the users table
mkdir src && vi src/conn_mongo_db.py
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

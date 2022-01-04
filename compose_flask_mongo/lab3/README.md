# Flask + Mongo DB with docker-compose.yml

## Setup the Mongo DB
```bash
vi docker-compose.yml

# open the USL
localhost:8081
```

## Create a db "user_account" and a table "users" in the Mongo Express GUI
- databese = user_account
- collection (table) = users


## Create a Flask Dockerfile

```bash
# create a inital db script
vi innit-db.js

# create a Dockerfile
vi Dockerfile

# add flask setup in the docker-compose.yml
vi docker-compose.yml
```
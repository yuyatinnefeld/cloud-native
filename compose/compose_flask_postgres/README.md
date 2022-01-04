# Docker Compose Flaks + Redis

## Info:
https://testdriven.io/blog/dockerizing-flask-with-postgres-gunicorn-and-nginx/

## Setup
```bash
# create a projet dir
mkdir compose_flask_postgres && cd compose_flask_postgres

# create setup fiels
mkdir -p services/web/app
vi services/web/app/__init__.py
vi services/web/app/main.py
vi service/web/requirements.txt
cd services/web
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
export FLASK_APP=app/main.py
flask run
```

## Create a Dockerfile in the "web" directory
```bash
FROM python:3.7-slim-buster
WORKDIR /code
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN pip install --upgrade pip
COPY ./requirements.txt /code/requirements.txt
COPY ./app /code/app
RUN pip install -r /code/requirements.txt
```

## Create a docker-compose.yml in the project directory
```bash
docker-compose build
docker-compose up -d
# open the URL
127.0.0.1:5000
```

## Update docker-compose.yml

## Add config.py in the "web/app/ directory

## Update requirements.txt
```bash
Flask==1.1.2
Flask-SQLAlchemy==2.5.1
psycopg2-binary==2.8.6
```

## Create a new DB
```bash
docker-compose up -d --build

# run psql
docker-compose exec db psql --username=hello_flask --dbname=hello_flask_dev
...
hello_flask_dev=# \l

# connect to hello_flask_dev db
hello_flask_dev=# \c hello_flask_dev

# check the tables
hello_flask_dev=# \dt

exit

# call the create_db of main.py to create user table in the hello_flask_dev 
docker-compose exec web python ./app/main.py create_db


# run psql
docker-compose exec db psql --username=hello_flask --dbname=hello_flask_dev
...
hello_flask_dev=# \l

# connect to hello_flask_dev db
hello_flask_dev=# \c hello_flask_dev

# check the tables
hello_flask_dev=# \dt

# check if the volume was created
docker volume ls
docker volume inspect compose_flask_postgres_postgres_data
```

## Clean up
```bash
docker-compose down
docker system prune -a
```
# Docker Compose Flaks + Redis

## Info:
https://docs.docker.com/compose/gettingstarted/

## Initial Setup 
```bash
# create a dir
mkdir compose_flask_redis
cd compose_flask_redis

# create setup fiels
vi requirements.txt
cd app
vi app/main.py
vi app/__init__.py
vi Dockerfile
```

## Create an inital docker image 
```bash
FROM python:3.7-slim
ENV PYTHONUNBUFFERED True
WORKDIR /code
COPY ./app /code/app
COPY ./requirements.txt /code/requirements.txt
CMD [ "/bin/bash" ]
```

# test docker run
```bash
docker image build -t sample/flask_redis:latest .
docker container run -it -p 5000:5000 --name flask_redis -v ${PWD}/app:/app sample/flask_redis:latest

# execute in the docker contaienr
pip install --no-cache-dir --upgrade -r /code/requirements.txt
python /code/app/main.py
exit
```

## Update Dockerfile

```bash
FROM python:3.7-slim
ENV PYTHONUNBUFFERED True
WORKDIR /code
COPY ./app /code/app
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
CMD python /code/app/main.py
```

## Docker Compose
```bash
# build
docker build -t compose-flask .

# create compose file
vi docker-compose.yml

# docker run
docker-compose up

# Open the URL and check the function
http://localhost:5000

# list containers
docker-compose ps

# clean up
docker-compose down
```




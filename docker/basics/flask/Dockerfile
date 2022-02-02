FROM python:3.8-slim-buster

LABEL maintainer yuyatinnefeld@gmail.com
RUN useradd -ms /bin/bash yuya
USER yuya

WORKDIR /app
COPY requirements.txt requirements.txt
COPY ./app.py ./app.py

USER root
RUN pip3 install -r requirements.txt
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
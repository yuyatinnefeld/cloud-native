FROM python:3.7
LABEL maintainer yuyatinnefeld@gmail.com
RUN groupadd -r yt && useradd -r -g yt yuya
USER yuya
WORKDIR /app
COPY . /app
USER root
RUN pip install -r requirements.txt
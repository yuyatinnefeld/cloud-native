FROM python:3.7
LABEL maintainer yuyatinnefeld@gmail.com
RUN groupadd -r yt && useradd -r -g yt yuya
USER yuya
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
FROM python:3.7-slim
LABEL maintainer yuyatinnefeld@gmail.com
ENV PYTHONUNBUFFERED True
ENV FLASK_APP=/code/app/main.py
ENV FLASK_RUN_HOST=0.0.0.0
WORKDIR /code
COPY ./app /code/app
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
CMD ["flask", "run"]
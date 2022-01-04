FROM python:3.7-slim
WORKDIR /code
COPY ./app /code/app
COPY ./requirements.txt /code/requirements.txt
ENV PYTHONUNBUFFERED True
ENV FLASK_APP=/code/app/main.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
CMD ["flask", "run"]
FROM python:3.7-slim
WORKDIR /code
COPY ./requirements.txt /code/requirements.txt
COPY ./app /code/app
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV FLASK_APP=/code/app/main.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
CMD ["flask", "run"]
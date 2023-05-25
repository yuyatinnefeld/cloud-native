FROM python:3.10

COPY requirements.txt /usr/src/requirements.txt
RUN pip install --no-cache-dir -r /usr/src/requirements.txt

EXPOSE 8080

COPY ./app /app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
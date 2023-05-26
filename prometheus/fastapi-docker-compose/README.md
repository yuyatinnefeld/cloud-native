# Prometheus FastAPI Instrumentator


## Test Application
```bash
# run the app
uvicorn app.main:app --reload

# check the metrics
curl http://127.0.0.1:8000/metrics/
```

## Create and push Image into Docker Repo
```bash
colima start

export IMAGE_NAME=fastapi_prometheus:1.0.0
export REPO=yuyatinnefeld

# push the image into the repo
docker build -t $IMAGE_NAME .
docker tag $IMAGE_NAME $REPO/$IMAGE_NAME
docker push $REPO/$IMAGE_NAME

# test
docker run -p 8080:8080 --name fastapi-prom $REPO/$IMAGE_NAME
curl http://127.0.0.1:8080/metrics/
```

## Create and deploy services with Docker Compose
```bash
vi docker-compose.yaml
docker-compose up -d prometheus
docker-compose up -d grafana
docker-compose up -d grafana-dashboards
docker-compose up -d fastapi
docker ps


# test services
open http://127.0.0.1:8080/metrics # fastapi
open http://127.0.0.1:3000 # grafana > USER: ADMIN, PASSWORD: ADMIN
open http://127.0.0.1:9090 # prometheus

# run PromQL
- python_info
- scrape_duration_seconds

```

## Clean up
```bash
docker-compose down
colima delete
```
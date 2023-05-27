# Prometheus FastAPI Instrumentator

## Source
- https://github.com/jeremyjordan/ml-monitoring

## Test FastAPI Application
```bash
cd demo-app

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

## Deploy - Docker Compose
`/docker-compose`

## Deploy - Kubernetes

`/k8s`

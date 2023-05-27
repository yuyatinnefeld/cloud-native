## FastAPI App

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

export IMAGE_NAME=fastapi_prometheus:1.1.0
export REPO=yuyatinnefeld

# create and test image
docker build -t $IMAGE_NAME .
docker run -p 8080:8080 --name fastapi $IMAGE_NAME

# push the image into the repo
docker tag $IMAGE_NAME $REPO/$IMAGE_NAME
docker push $REPO/$IMAGE_NAME

# test repo image
docker run -p 8888:8080 --name fastapi-prom $REPO/$IMAGE_NAME
curl http://127.0.0.1:8888/metrics/

colima delete
```
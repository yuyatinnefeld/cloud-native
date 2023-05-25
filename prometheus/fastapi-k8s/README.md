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

## Create and deploy with kubernetes
```bash
vi fastapi-deploy.yaml

NS=prometheus
kubectl create namespace $NS
kubectl config set-context --current --namespace=$NS

kubectl apply -f fastapi-deploy.yaml
kubectl get all

# test
kubectl port-forward service/fastapi-svc 8080
curl http://127.0.0.1:8080/metrics/
```

## Run Prometheus
```bash
NS=prometheus

# deploy prometheus
helm install prometheus-operator prometheus-community/kube-prometheus-stack --namespace $NS
kubectl get all --namespace $NS

# run grafana
PORT=3000

kubectl get deployment
DEPLOYMENT_NAME=prometheus-operator-grafana
kubectl port-forward deployment/$DEPLOYMENT_NAME $PORT
# user=admin, pwd=prom-operator
```
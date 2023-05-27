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

## Create and deploy fastapi app with kubernetes
```bash
minikube start --cpus 4 --memory 8192

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

POD_NAME=prometheus-prometheus-operator-kube-p-prometheus-0
PORT=9090
kubectl port-forward $POD_NAME $PORT
```
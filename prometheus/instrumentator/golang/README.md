# Prometheus Golang Instrumentator

## Create a docker image and push into Dockerhub
```bash
export REPO=yuyatinnefeld
export IMAGE_NAME=go-prometheus-app

docker build -t $REPO/$IMAGE_NAME .
docker run -p 8080:8080 -d $REPO/$IMAGE_NAME

curl http://127.0.0.1:8080/
curl http://localhost:8080/metrics

docker push $REPO/$IMAGE_NAME

# test repo image
docker run -p 8080:8080 --name golang-prom $REPO/$IMAGE_NAME
curl http://127.0.0.1:8080
curl http://127.0.0.1:8080/metrics/
```

## Run Minikube
```bash
minikube start --cpus 4 --memory 8192
```

## Create Namespace
```bash
NS=prometheus
kubectl create namespace $NS
kubectl config set-context --current --namespace=$NS
```

## Deploy Golang Web App
```bash
kubectl apply -f golang.yaml -n $NS
kubectl get deploy
kubectl get svc

# test
kubectl port-forward svc/golang-app-svc 8080
curl http://127.0.0.1:8080/metrics/
```

## Run Prometheus
```bash
NS=prometheus
helm install prometheus-stack prometheus-community/kube-prometheus-stack -n $NS
kubectl get all -n $NS

# deploy service monitor for scraping
kubectl apply -f service-monitor.yaml -n $NS

# check service discovery and target
kubectl port-forward svc/prometheus-stack-kube-prom-prometheus 9090
```

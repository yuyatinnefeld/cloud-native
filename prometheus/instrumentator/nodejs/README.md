# Prometheus Node.js Instrumentator

- https://github.com/slanatech/swagger-stats

## Create a docker image and push into Dockerhub
```bash
cd node-demo-app
export REPO=yuyatinnefeld
export IMAGE_NAME=node-web-app

docker build -t $REPO/$IMAGE_NAME .
docker run -p 5000:5000 -d $REPO/$IMAGE_NAME
curl http://127.0.0.1:5000/
curl http://localhost:5000/swagger-stats/metrics

docker push $REPO/$IMAGE_NAME
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

## Deploy Node.js app
```bash
kubectl apply -f nodejs.yaml -n $NS
kubectl get deploy
kubectl get svc

# test
kubectl port-forward svc/node-app-svc 5000
curl http://127.0.0.1:5000/
curl http://127.0.0.1:5000/swagger-stats/metrics
```

## Run Prometheus
```bash
NS=prometheus
helm install prometheus prometheus-community/kube-prometheus-stack -n $NS
kubectl get all -n $NS

# set service monitor for scraping
kubectl get crd
kubectl get servicemonitors.monitoring.coreos.com 
kubectl apply -f service-monitor.yaml
kubectl get servicemonitor
```

## Open Prometheus UI
```bash
PORT=9090
POD=prometheus-prometheus-kube-prometheus-prometheus-0
kubectl port-forward $POD $PORT
open http://127.0.0.1:9090/targets?search=node-app

# execute with the job-id
{job="node-app-svc"}
```

## Create Alert
```bash
# deploy rules
kubectl apply -f rules.yaml
kubectl get prometheusrule | grep node-app
open http://127.0.0.1:9090/rules

# update alertmanager configuration
helm show values prometheus-community/kube-prometheus-stack > values.yaml
helm upgrade prometheus prometheus-community/kube-prometheus-stack -f values.yaml

# verify
kubectl get alertmanagers.monitoring.coreos.com -o yaml

# deploy alert manager
kubectl apply -f alertmanager.yaml

# check alert manager
kubectl get svc
kubectl port-forward svc/alertmanager-operated 9093
open http://127.0.0.1:9093/#/alerts
```

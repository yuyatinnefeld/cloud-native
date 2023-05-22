# Prometheus

## About
Prometheus collects and stores its log-metrics as time series data, i.e. metrics information is stored with the timestamp at which it was recorded, alongside optional key-value pairs called labels.

## Main Components (Severs)
- Data Retrieval Worker (for Pulling metrics)
- Time Series Database (for Storing metrics)
- HTTP Server (for Accepting PromQL queries / Connect to visualizataion tools like Grafana)

## What does Prometheus monitor?
- Linux / Windows Server
- Apache Server
- Single Application
- Database Service

## Which metrics are monitored?
- CPU Status
- Memory/Disk Space Usage
- Requests Counts
- Exeptions Count
- Request Duration

## Pros and Cons
- Stand-alone and self-containing / Limits monitoring
- Reliable / Difficult to scale
- Less complex

## Setup Prometheus

### Using helm chart operator
```bash
# run k8s cluster with enoght resources
minikube start --cpus 4 --memory 8192

# install helm cli
brew install kubernetes-helm

# add the repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# search the prometheus operator
helm search repo prometheus-community

# add namespace
NS=prometheus
kubectl create namespace $NS
kubectl config set-context --current --namespace=$NS

# install the operator
helm list
helm install prometheus-operator prometheus-community/kube-prometheus-stack --namespace $NS

# check if the crds (custom resource definition) alertmanagers is installed
kubectl get crds

# check the all components
kubectl get all -n prometheus
```

### Prometheus UI Setup
```bash
kubectl get pods
POD_NAME=prometheus-prometheus-operator-kube-p-prometheus-0

# check the port
kubectl describe pod $POD_NAME
PORT=9090
kubectl port-forward $POD_NAME $PORT
```

## clean up
```bash
kubectl config set-context --current --namespace=default
kubectl delete all --all -n prometheus
kubectl get all -n prometheus

# delete minicube
minikube delete --all
```

# Install Prometheus + Grafana

## Using helm chart operator
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

## Prometheus UI Setup
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
# delete all components
helm delete prometheus-operator

# delete minicube
minikube delete --all
```

# ELK Stack

## About
- E: elestic search (distributed search and analytics engine)
- L: logstash (data ingestion tool)
- K: kibana (data visualization tool)

- ELK stack gives you the ability to aggregate logs from all your systems and applications, analyze these logs, and create visualizations for application and infrastructure monitoring, faster troubleshooting, security analytics, and more.

- ECK: Elastic Cloud on Kubernetes automates the deployment, provisioning, management, and orchestration of Elasticsearch, Kibana, APM Server, Enterprise Search, Beats, Elastic Agent, and Elastic Maps Server on Kubernetes based on the operator pattern.

## Setup ELK Stack

### Initial Setup (Minikube + Helm Repo)
```bash
# run k8s cluster with enoght resources
minikube start --cpus 2 --memory 8192 --vm-driver=hyperkit

# these addons must be enabled
minikube addons enable default-storageclass
minikube addons enable storage-provisioner
minikube config view vm-driver

# check capacity
kubectl describe nodes -n elk

# install helm cli
brew install kubernetes-helm

# add repo
helm repo add elastic-community https://helm.elastic.co
helm repo update

# search chart
helm search repo elastic-community
```

### Run Elastic Search
```bash
# install chart
helm install es-quickstart elastic/elasticsearch -f es-values.yaml -n elk --create-namespace

# verify
kubectl get pods -n elk -l app=elasticsearch-master -w

kubectl get secrets --namespace=elk elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
# IDSYrlj3FNI4otf4

# test
helm --namespace=elk test es-quickstart

# check capacity
kubectl describe nodes -n elk

# connect elasticsearch port
kubectl get service --namespace=elk
SERVICE_NAME="elasticsearch-master" 
PORT=9200
kubectl port-forward service/$SERVICE_NAME $PORT -n elk
```

### Run Kibana 
```bash
# open another terminal
helm install kibana elastic/kibana -n elk --wait

# verify
kubectl get pods --namespace=elk -l release=kibana -w
kubectl get secrets --namespace=elk elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d

kubectl get service --namespace=elk
SERVICE_NAME="kibana-kibana" 
PORT=5601

kubectl port-forward deployment/$SERVICE_NAME $PORT -n elk
# username: elastic
# password: IDSYrlj3FNI4otf4 (secret)
```

![Screenshot](elasticsearch-ui.png)

### Setup filebeat for metrics
```bash
# open another terminal
helm install filebeat elastic/filebeat -n elk --wait

# verify
kubectl get pods --namespace=elk -l app=filebeat-filebeat -w
```

## Clean up
```bash
kubectl get all -n elk
kubectl delete all --all -n elk
kubectl delete namespace elk
minikube delete --all
```

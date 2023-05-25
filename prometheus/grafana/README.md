# Prometheus + Grafana

#### Grafana UI
![Screenshot](../pics/grafana-k8s.png)

#### Prometheus UI
![Screenshot](../pics/prometheus-ui.png)


## Prometheus + Grafana Setup

- using helm chart to deploy prometheus k8s operator
- https://github.com/prometheus-community/helm-charts

### Using helm chart operator

### Grafana UI Setup
```bash
# check the service type. (ClusterIP = Internal Service > port-forward necessary)
kubectl get services

# check the grafana pod
kubectl get pods
POD_NAME=prometheus-operator-grafana-5948748bb4-c5rrf
kubectl describe pod $POD_NAME

# check the grafana logs and note default user and port
kubectl logs $POD_NAME -n prometheus -c grafana | grep user=
kubectl logs $POD_NAME -n prometheus -c grafana | grep address=

USER=admin
PORT=3000

# check the deployment-name
kubectl get deployment
DEPLOYMENT_NAME=prometheus-operator-grafana

kubectl port-forward deployment/$DEPLOYMENT_NAME $PORT

# open port
http://localhost:3000

# username: admin
# password: prom-operator (adminPassword from https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml)
```

![Screenshot](../pics/grafana-ui.png)

## PromQL in Grafana
1. Menu > Explore
2. Select Source (Prometheus)
3. Builder > Code
4. Metrics Browser > 'scrape_duration_seconds'
5. Run Query


### clean up
```bash
kubectl config set-context --current --namespace=default
kubectl delete all --all -n prometheus
kubectl get all -n prometheus

# delete minicube
minikube delete --all
```

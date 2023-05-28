# Prometheus FastAPI Instrumentator

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

## Deploy FastAPI app
```bash
kubectl apply -f fastapi.yaml -n $NS
kubectl get deploy
kubectl get svc

# test
kubectl port-forward svc/fastapi-app-svc 8080
curl http://127.0.0.1:8080/metrics/
```

## Run Prometheus
```bash
NS=prometheus
helm install prometheus-stack prometheus-community/kube-prometheus-stack -n $NS
kubectl get all -n $NS

# deploy service monitor for scraping
kubectl apply -f service-monitor.yaml -n $NS
```


## Run Grafana
```bash
NS=prometheus
kubectl port-forward svc/prometheus-stack-grafana 3000:80 -n $NS

# PromQL
- process_cpu_seconds_total
- python_gc_collections_total
- python_info
- fastapi_model_regression_model_output_count
```

## Clean up

```bash
helm delete prometheus-stack
kubeclt delete -f fast-deploy.yaml
kubectl get all
minikube delete --all
```
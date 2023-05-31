# PostgreSQL

## Components Overview
Deploy the following components
- PostgreSQL App
- PostgreSQL Exporter (for pulling metrics)
- ServiceMonitor

## Open Prometheus UI and Check the Setup

1. Open UI
```bash
SERVICE=$(kubectl get svc -o name | grep prometheus-operator-kube-p-prometheus)
PORT=9090
kubectl port-forward $SERVICE $PORT
```
2. Check Targets
Status > Targets

3. Check Servicemonitor = Prometheus Targets
```bash
kubectl get servicemonitor

# check details example = grafana
kubectl get servicemonitor prometheus-operator-grafana -o yaml
```

4. Check the 'release name of ServiceMonitorSelector'
```bash
kubectl get crd
kubectl get prometheuses.monitoring.coreos.com -o yaml
kubectl get prometheuses.monitoring.coreos.com -o yaml | grep release

# you need this RELSESE NAME for target applications
release="prometheus-operator"
```

## Deploy PostgreSQL
- https://github.com/bitnami/charts/blob/main/bitnami/postgresql/README.md
```bash
NS=prometheus
helm install postgresql-operator oci://registry-1.docker.io/bitnamicharts/postgresql -f postgresql-operator-values.yaml --namespace $NS
```

## Deploy PostgreSQL Exporter

3 Components
- exporter application (exposes metrics endpoint)
- service (for connecting to the exporter)
- serviceMonitor (to be discovered)

### Use Helm Chart for these 3 components
- https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus-postgres-exporter
```bash

# create custom export config file
helm show values prometheus-community/prometheus-postgres-exporter > values.yaml

# deploy chart with the custom config file
helm install postgres-exporter prometheus-community/prometheus-postgres-exporter -f postgresql-exporter-values.yaml --namespace $NS
helm ls

# check 3 components
kubectl get pods | grep postgres-exporter
kubectl get svc | grep postgres-exporter
kubectl get servicemonitor | grep postgres-exporter

# check the label
kubectl get servicemonitor postgres-exporter-prometheus-postgres-exporter

# check the collecting data
export POD_NAME=$(kubectl get pods --namespace $NS -l "app=prometheus-postgres-exporter,release=postgres-exporter" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME 8080:9187
curl http://127.0.0.1:8080/metrics
open http://127.0.0.1:8080

# check the target in prometheus
http://127.0.0.1:9090/targets?search=postgres

# start grafane
kubectl port-forward deployment/prometheus-operator-grafana  3000
# user: admin
# password: prom-operator
Menu > Explore > Run Query

- postgres_exporter_build_info

```

## Clean up

```bash
helm delete postgresql-operator
helm delete prometheus-operator
helm delete postgres-exporter 
kubectl get all
minikube delete --all
```
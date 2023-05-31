# MongoDB

## Components Overview
Deploy the following components
- MongoDB App
- MongoDB Exporter (for pulling metrics)
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
RELESE_NAME="prmetheus-operator"
```

## Deploy MongoDB
```bash
kubectl apply -f mongodb.yaml
kubectl get pod
```

## Deploy MongoDB Exporter

3 Components
- exporter application (exposes metrics endpoint)
- service (for connecting to the exporter)
- serviceMonitor (to be discovered)

### Use Helm Chart for these 3 components
- https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus-mongodb-exporter
```bash
NS=prometheus

# create a custom exporter config file
helm show values prometheus-community/prometheus-mongodb-exporter > values.yaml

# deploy chart with the custom config file
helm install mongodb-exporter prometheus-community/prometheus-mongodb-exporter -f mongodb-exporter-values.yaml --namespace $NS
helm ls

# check 3 components
kubectl get pods | grep mongodb-exporter
kubectl get svc | grep mongodb-exporter
kubectl get servicemonitor | grep mongodb-exporter

# check the label
kubectl get servicemonitor mongodb-exporter-prometheus-mongodb-exporter -o yaml

# check the collecting data
kubectl get svc | grep mongodb-exporter
kubectl port-forward service/mongodb-exporter-prometheus-mongodb-exporter 9216
curl http://127.0.0.1:9216/metrics
open http://127.0.0.1:9216/

# check the target in prometheus
http://127.0.0.1:9090/targets?search=mongodb
# You can see
# serviceMonitor/prometheus/mongodb-exporter-prometheus-mongodb-exporter/0 (1/1 up)

# start grafane
kubectl port-forward deployment/prometheus-operator-grafana  3000
# user: admin
# password: prom-operator
Menu > Explore > Run Query

- mongodb_sys_mounts_capacity
- mongodb_sys_cpu_processes

```

## Clean up

```bash
helm delete mongodb-exporter
helm delete prometheus-operator
kubectl delete deployment mongodb-deployment
kubectl delete service mongodb-service
kubectl get all
```
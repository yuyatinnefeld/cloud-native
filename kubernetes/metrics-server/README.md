## setup

```bash
# option 1 - for minikube
minikube addons enable metrics-server

# option 2 - for kubectl
git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git
cd kubernetes-metrics-server
kubectl create -f .
```

## use
```bash
kubectl top nodes

kubectl top pods
```
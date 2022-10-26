# Services

## Port Types
- NodePort (Port of Cluster Node)
- Service ClusterIP Port (Port of Service)
- TargetPort (Port of Container)

## setup
```bash
# create service with NodePort
kubectl create -f service-definition.yaml

#verify
kubectl get service

# get ip of minikube cluster
minikube ip

# call the nginx website
export NODE_CLUSTER_IP="192.168.64.12"
curl http://$NODE_CLUSTER_IP:30007

# clean up
kubectl delete -f service-definition.yaml
```

## create quickly a service 
```bash
kubectl run nginx --image=nginx
kubectl expose pod nginx --type=NodePort --port=80 --name nginx-service --dry-run=client -o yaml > nginx-service.yaml


kubectl create -f nginx-service.yaml

# create a redis service with ClusterIP and pod
kubectl run redis --image=redis
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml
```

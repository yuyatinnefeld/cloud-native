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

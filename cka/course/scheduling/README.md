# Node Affinity
- You can constrain a Pod so that it is restricted to run on particular node(s), or to prefer to run on particular nodes. There are several ways to do this and the recommended approaches all use label selectors to facilitate the selection.
- Kubernetes node affinity is an advanced scheduling feature that helps administrators optimize the distribution of pods across a cluster.
- Node Affinity is more flexible then label selectors

## Setup
```bash
# you can only select the labe
cat pod_1.yaml

# you can define flexible with node affinity (select not small size node)
cat pod_2.yaml

# create deployment "red" which will be triggerd only with color=red
kubectl create deployment red --image=nginx --replicas=3 --dry-run=client -o yaml > red.yaml

# update the deployment with node affinity
vi red.yaml

# deploy
kubectl create -f red.yaml

```

# Resource Requirements and Limits
- Pods have following resources: CPU, Memory/RAM, Disk/Storage
- k8s Scheduler decides which node a pod goes to
- by default k8s assumes that a pod requires 0.5 CPU, 256 Mi MEM, 


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

# Taints and TOlerations
- Taints are a Kubernetes node property that enable nodes to repel certain pods. 
- Tolerations are a Kubernetes pod property that allow a pod to be scheduled on a node with a matching taint.

## Setup
```bash
# check taints of nodes
kubectl describe node <NODE_NAME> | grep Taints

# kubectl setup taints 
# TAINT-EFFECT: NoSchedule, PreferNoSchedule or NoExecute
kubectl taint nodes <NODE_NAME> key=vavlue:<TAINT-EFFECT>

# create pod with a toleration set
kubectl run <POD_NAME> --image=nginx --dry-run=client -o yaml > pod.yaml
kubectl create -f pod.yaml

# remove the taint
kubectl taint nodes <NODE_NAME> key=vavlue:<TAINT-EFFECT>-

#ex
#kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-
```
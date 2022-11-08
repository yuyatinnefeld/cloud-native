## Core Concept

### Lessons
- 1. https://kodekloud.com/topic/practice-test-pods-2/


### Nice to know cmd
```bah
# create deploy file
kubectl run redis --image=redis --dry-run=client -o yaml > redis.yaml
kubectl create -f redis.yaml

k create -f redis.yaml

# check the node
kubectl get pods -o wide

# check the node of redis
ubectl get pods | grep ^redis

# create replication controller
kubectl create -f rc-deploy.yaml
kubeclt get pods
kubectl get replicationcontroller

# delete running pod and create a new pod with the configration
kubectl replace --force -f pod.yaml
```

### k8s Imperative vs Declarative 
```bash
# Imperative way

kubectl run --image=nginx nginx
kubeclt create -f nginx.yaml
kubeclt delete -f nginx.yaml
kubeclt replace -f nginx.yaml

# Declarative way

kubeclt apply -f nginx.yaml
```

### Create Static pods
```bash
cd /etc/kubernetes/manifests
vi pod.yaml

```
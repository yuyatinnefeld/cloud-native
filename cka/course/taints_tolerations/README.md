# Taints and TOlerations
- Taints are a Kubernetes node property that enable nodes to repel certain pods. 


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
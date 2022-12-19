# cluster maintenance

## cluster upgrade process
0. determine which kubeadm version to upgrade to

```bash
kubeadm upgrade plan
kubeadm version
```

1. kubeadm upgrade
```bash
 # replace x in 1.xx.x-00 with the latest patch version
 apt-mark unhold kubeadm && \
 apt-get update && apt-get install -y kubeadm=1.xx.x-00 && \
 apt-mark hold kubeadm
 sudo kubeadm upgrade apply v1.xx.x
```
- kube-apisever upgrade
- kube-controll-manager upgrade
- kube-scheduler upgrade
- kube-proxy upgrade
2. determine which kubeadm version to upgrade to

```bash
kubeadm version
kubectl get nodes
```

3. kubelet upgrade
- 3.1 master-node (control-plane) upgrade
```bash
kubectl drain controlplane --ignore-daemonsets

# replace x in 1.xx.x-00 with the latest patch version
apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.xx.x-00 kubectl=1.xx.x-00 && \
apt-mark hold kubelet kubectl

# restart kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# mark the controlplane node as "Schedulable" again
kubectl uncordon controlplane

```
- 3.2 worker-node upgrade
```bash
# check the worker nodes
kubectl get nodes

# make node 'UnSchedulable'
kubectl drain <node-to-drain> --ignore-daemonsets

# verify
kubectl get nodes

# get the ip address
k get nodes -o wide

# ssh conn
ssh 10.7.172.12

# replace x in 1.xx.x-00 with the latest patch version
apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.xx.x-00 && \
apt-mark hold kubeadm
sudo kubeadm upgrade node

sudo systemctl daemon-reload
sudo systemctl restart kubelet

# exit from worker-node
exit

# replace <node-to-uncordon> with the name of your node
kubectl uncordon <node-to-uncordon>

```

### Info
https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

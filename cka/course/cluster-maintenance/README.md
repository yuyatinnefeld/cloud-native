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



## Backup

### Option 1 - backup resource config
```bash
kubectl get all --all-namespaces -o yaml > all-deploy-setup.yaml
```

### Option 2 - backup etcd cluster
```bash
# save the config
ETCDCTL_API=3 etcdctl snapshot save snapshot.db

# view state
ETCDCTL_API=3 etcdctl snapshot status snapshot.db

# restore the data
service kube-apiserver stop

export RESTORE_PATH="/var/lib/etc-from-backup"

ETCDCTL_API=3 etcdctl snapshot restore snapshot.db --data-dir $RESTORE_PATH

# edit the etcd.service file

# restart
systemctl daemon-reload
service etcd restart
service kube-apiserver start

```
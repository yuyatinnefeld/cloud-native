# cluster maintenance

## cluster upgrade process
0. determine which kubeadm version to upgrade to

`kubeadm upgrade plan`

1. kubeadm upgrade
- kube-apisever upgrade
- kube-controll-manager upgrade
- kube-scheduler upgrade
- kube-proxy upgrade
2. determine which kubeadm version to upgrade to

`kubectl get nodes`

3. kubelet upgrade
- 3.1 master-node (control-plane) upgrade 
- 3.2 worker-node upgrade

### Info
https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

# CKA (certified k8s administrator)


## References
- CKA: https://www.cncf.io/certification/cka/
- Curriclum: https://github.com/cncf/curriculum/blob/master/CKA_Curriculum_v1.24.pdf
- Handbook: https://docs.linuxfoundation.org/tc-docs/certification/lf-handbook2
- Tips: https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad
- KillerShell: https://killer.sh
- Udemy: https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests
- CKA Prep (EN): https://github.com/kodekloudhub/certified-kubernetes-administrator-course
- CKA Prep (JP): https://qiita.com/nakamasato/items/43796af050b12a4c73e8


## Core Components
- Worker Nodes: host application as containers
- Master Nodes: manage, plan, schedule, monitor Worker Nodes
- ETCD: Cluster: is a DB to store the cluster information as key-val-format
- kube-scheduler: is a control plane process and care about size, capacity, number of containers 
- Controller manager: manages nodes, replications and controller
- Kube-apiserver: is responsible for orchestration all operations within the cluster
- Runtime Engine: makes possible to run containers (Docker, ContainerD, rkt)
- Kubelet: is an agent that runs on each worker nodes (ship captain) and communicate with kube-apiserver to deploy and destroy containers
- Kube-proxy: ensure the communication of each worker nodes (e.g. communication between DB server nodes and web server nodes)

### ETCD
- a distributed key-value data store for consistently and reliably storing
- replicated (distributed), consistent, secure, highly available (not single point of failure)
- storing the information regarding the cluster (e.g. pods, nodes, configs, secrets, etc.)

### Kubeadm vs Minicube
- Minicube: light, easy -> k8s beginner
- Kubeadm: production level, heavy -> k8s expert
- install kubeadm: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

### Details about core components
```bash
# kubeapiserver
kubectl -n kube-system describe  pod kube-apiserver-minikube

# kube-controller-manager
kubectl -n kube-system describe  pod kube-controller-manager-minikube

# kube-scheduler
kubectl -n kube-system describe  pod kube-scheduler-minikube
```
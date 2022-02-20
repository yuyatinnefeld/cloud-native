# install helm 
brew install kubernetes-helm

# helm list
helm repo list

# search repo
helm search hub mongodb
helm search repo redis

# we will use this on
https://artifacthub.io/packages/helm/bitnami/mongodb


# add repo
helm repo add bitnami https://charts.bitnami.com/bitnami

# search added repo
helm search repo bitnami/mongodb
helm search repo redis


# install mongodb
helm install mongo-release1 bitnami/mongodb
helm list
kubectl get deployment
kubectl get replicaset
kubectl get pod

# delete release
helm uninstall mongo-release1
helm list

# delete repo
helm repo remove bitnami



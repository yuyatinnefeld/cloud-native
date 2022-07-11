# cmd
```bash
helm install <RELEASE_NAME> <LINK>
helm list
helm upgrade
helm rollback
helm uninstall <RELEASE_NAME>
```

## example
```bash
# search repo
helm search repo prometheus

# add prometheus in your repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# update repo
helm repo update

# show all charts from your repo
helm repo list

# install
RELEASE_NAME=kube-prometheus-stack

helm install $RELEASE_NAME prometheus-community/kube-prometheus-stack

# verify
kubectl get all
helm list

# show setup
helm show values prometheus-community/kube-prometheus-stack

# download the setup file
helm pull prometheus-community/kube-prometheus-stack
tar zcvf <FILE_NAME>
cat kube-prometheus-stack/values.yaml
cd kube-prometheus-stack

# delete
helm uninstall $RELEASE_NAME

```

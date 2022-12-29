# setup
```bash
# add helm repo
helm repo add argo https://argoproj.github.io/argo-helm


# install repo
helm install argo-cd --namespace argocd --create-namespace argo/argo-cd --version 3.6.11

# verify
helm list -n argocd
kubectl get pods -n argocd

# access argocd with port-forward
kubectl port-forward service/argo-cd-argocd-server -n argocd 8080:443

# open an another termin

# create a pwd and save it
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo

# login argocd
argocd login localhost:8080

# change the pwd


# create gitlab conn
argocd repo add https://gitlab.com/yt-learning/k8s-sample.git --username yuyatinnefeld --password ●●●●●●●●

# verify
argocd repo list

# setup wordpress application (web browser UI)


# access wordpress
kubectl port-forward service/wordpress -n dev 30000:80

# delete application
argocd app delete wordpress
```

### source:
- https://atmarkit.itmedia.co.jp/ait/articles/2107/30/news018.html
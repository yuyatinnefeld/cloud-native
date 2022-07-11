# install argo cd cli
brew install argocd


# install argo cd
kubectl create namespace argocd
kubens argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# check if all pods are running

# check services
kubectl get svc -n argocd

# argocd-server port connection to access argocd ui
kubectl port-forward svc/argocd-server -n argocd 8080:443

# open
127.0.0.1:8080

# check the pwd to login the argocd ui
kubectl get secret argocd-initial-admin-secret -n argocd -o yaml
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

# login the argocd ui


# install the dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

# access dashboard
kubectl proxy

# create admin user
kubectl apply -f dashboard-admin.yaml

# get admin token
kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount admin-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode

# Open the URL and copy the token
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login

# add the read uber
kubectl apply -f dashboard-read-only.yaml
kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount read-only-user -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode

# open the URL and copy the token
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login


# ingress setup
minikube addons enable ingress

check backend service name
kubectl get all -n kubernetes-dashboard # >> kubernetes-dashboard 
kubectl apply -f ingress.yaml
kubectl get ingress


# clean up
kubectl delete -f dashboard-admin.yaml
kubectl delete -f dashboard-read-only.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml






# Service Type
# ClusterIP (default)
# NodePort
# LoadBalancer
# Ingress

# we will create Service with NodePort here
# 0. create a demo pod
# 1. create firewall rule (TCP:31000 Port)
# 2. create a service with NodePort (31000)
# 3. add a label 'secure=enabled' into pod

# open kubernetes demo dir
cd ~/orchestrate-with-kubernetes/kubernetes

# check the pod settings
cat pods/secure-monolith.yaml

# create a secure-monolith-pod
kubectl create secret generic tls-certs --from-file tls/
kubectl create configmap nginx-proxy-conf --from-file nginx/proxy.conf
kubectl create -f pods/secure-monolith.yaml

# create a service
kubectl create -f services/monolith.yaml

# create firewall rule
gcloud compute firewall-rules create allow-monolith-nodeport \
  --allow=tcp:31000

# get an external IP address for one of the nodes
gcloud compute instances list

# try hitting the secure-monolith service 
EXTERNAL_IP=34.79.199.47
curl -k https://${EXTERNAL_IP}:31000 #cannot connect because currently the monolith service does not have endpoint

# check labels by monolith pod
kubectl get pods -l "app=monolith"
kubectl get pods -l "app=monolith,secure=enabled"

# add label for monolith pod
kubectl label pods secure-monolith 'secure=enabled'
kubectl get pods secure-monolith --show-labels

# check the endpoint
kubectl describe services monolith | grep Endpoints

# try again
curl -k https://${EXTERNAL_IP}:31000 #cannot connect because currently the monolith service does not have endpoint

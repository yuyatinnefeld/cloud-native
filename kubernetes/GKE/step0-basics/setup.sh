# create a simple nginx frontend website with nginx + LB

# set a default compute zone
gcloud config set compute/zone europe-west1-b

# create a GKE clsuter
CLUSTER_NAME="webfrontend"
gcloud container clusters create ${CLUSTER_NAME}

# get auth credentials for the cluster to interact with it
gcloud container clusters get-credentials ${CLUSTER_NAME}

# deploy nginx
kubectl create deploy nginx --image=nginx:1.17.10

# expose nginx container to the internet
kubectl expose deployment nginx --port 80 --type LoadBalancer
kubectl get services

EXTERNAL_IP=34.136.152.149
curl -i http://$EXTERNAL_IP
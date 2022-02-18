# set a default compute zone
gcloud config set compute/zone europe-west1-b

# create a GKE clsuter
CLUSTER_NAME="my-cluster"
gcloud container clusters create ${CLUSTER_NAME}

# get auth credentials for the cluster to interact with it
gcloud container clusters get-credentials ${CLUSTER_NAME}

# deploy an application to the cluster
SERVER_NAME="hello-server"
IMAGE="gcr.io/google-samples/hello-app:1.0"
kubectl create deployment ${SERVER_NAME} --image=${IMAGE}
kubectl get deployment

# create kubernetes service
kubectl expose deployment ${SERVER_NAME} --type=LoadBalancer --port 8080

# check the external ip for hello-server
kubectl get service

# confirm the result
EXTERNAL_IP=35.226.88.78
curl http://${EXTERNAL_IP}:8080

# export
kubectl get deploy ${SERVER_NAME} -o yaml

# clean up
gcloud container clusters delete ${CLUSTER_NAME}
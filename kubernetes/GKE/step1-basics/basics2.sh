# set a default compute zone
gcloud config set compute/zone europe-west1-b

# create a GKE clsuter
CLUSTER_NAME="my-cluster"
gcloud container clusters create ${CLUSTER_NAME}

# get auth credentials for the cluster to interact with it
gcloud container clusters get-credentials ${CLUSTER_NAME}

# deploy an application to the cluster
DEPLOY_FILE="deployment.yaml"
kubectl apply -f ${DEPLOY_FILE}


# check the external ip for hello-server
kubectl get service

# confirm the result
EXTERNAL_IP=35.187.171.50
curl http://${EXTERNAL_IP}:80



# clean up
gcloud container clusters delete ${CLUSTER_NAME}
# Cloud Vision API from a Kubernetes Cluster

# Objectives

# - create a simple redis instance
# - create a web app
# - create worker that handles scraping reddit for image and classify them using the Vision AI
# - use pubsub to coordinate tasks between multiple worker instances

# Source: https://www.qwiklabs.com/focuses/1241?parent=catalog

######### setting up the environment #########

REGION="europe-west1"
ZONE="europe-west1-b"
CLUSTER_NAME="awwversion"

# set zone
gcloud config set compute/zone ${ZONE}

# create a gke cluster
gcloud container clusters create ${CLUSTER_NAME} \
    --num-nodes 2 \
    --scopes cloud-platform

# give credentials
gcloud container clusters get-credentials ${CLUSTER_NAME}
kubectl cluster-info

# create python environment
apt-get install -y virtualenv
python3 -m venv venv
source venv/bin/activate


######### deploy the sample data #########

# get the sample data
gsutil -m cp -r gs://spls/gsp066/cloud-vision .

# change to the directory
cd cloud-vision/python/awwvision

# build and deploy everthing
# Docker image will be built and uploaded to the Container Registry
# YAML file will be generated from templates
make all

######### check the kubernetes resources on the cluster #########

# get pods
kubectl get pods

# get deployments
kubectl get deployments -o wide

# get external ip
kubectl get svc awwvision-webapp
EXTERNAL_IP=" 23.236.61.91"

curl -i http://${EXTERNAL_IP}

#open browser
http://${EXTERNAL_IP}


######### clean up #########

# delete pods / deployments etc.
kubectl delete daemonsets,replicasets,services,deployments,pods,rc --all --all-namespaces

# delete GKE cluster
gcloud container clusters delete $CLUSTER
   
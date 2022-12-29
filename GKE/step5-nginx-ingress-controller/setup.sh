# NGINX Ingress Controller on Google Kubernetes Engine

# about
# In Kubernetes, Ingress allows external users and client applications access to HTTP services. 
# Ingress consists of two components: an Ingress Resource and an Ingress Controller:
# - Ingress Resource is a collection of inbound traffic rules
# - Ingress Controller acts upon the rules set by the Ingress Resource (HTTP or L7 LB)

# Objectives
# - deploy a simple k8s web application
# - deploy an NGINX Ingress Controller 
# - deploy an Ingress Resource
# - Testing NGINX Ingress fuctionality by accessing the L4 (TCP/UDP) load balancer

# Goal
# - Traffic (Frontend and Backend) Allocation via Ingress Controller

# Source: https://www.qwiklabs.com/focuses/872?parent=catalog

######### create a kubernetes cluster and deploy the app #########


# set a default zone
ZONE=us-central1-a
gcloud config set compute/zone ${ZONE}

# create a cluster
CLUSTER_NAME=nginx-tutorial
gcloud container clusters create ${CLUSTER_NAME} --num-nodes 2

# give credentials
gcloud container clusters get-credentials nginx-tutorial --region=us-central1-a

# install helm
helm version
helm repo add stable https://charts.helm.sh/stable
helm repo update

# deploy an application
IMAGE="gcr.io/google-samples/hello-app:1.0"
kubectl create deployment hello-app --image=${IMAGE}


######### deploying the NGINX Ingress Controller via Helm #########

# deploy Ingress Controller
HELM_REPO="stable/nginx-ingress"
helm install nginx-ingress ${HELM_REPO} --set rbac.create=true

# verify
kubectl get service

# Wait a few moments while the Google Cloud L4 Load Balancer gets deployed

# check the external IP
kubectl get service nginx-ingress-controller

EXTERNAL_LB_IP="34.134.71.158"
curl -i ${EXTERNAL_LB_IP}/healthz # status=200
curl -i ${EXTERNAL_LB_IP}/ #status=404


######### configure Ingress Resource to use NGINX Ingress Controller #########

# create ingress resource
touch ingress-resource.yaml


# apply the ingress reosuce
kubectl apply -f ingress-resource.yaml

# verify that Ingress Resource has been created
kubectl get ingress ingress-resource
#NAME               CLASS    HOSTS   ADDRESS   PORTS   AGE
#ingress-resource   <none>   *                 80      8s

# Note: The IP address for the Ingress Resource will not be defined right away. Wait a few moments for the ADDRESS field to get populated.



# The kind: Ingress dictates it is an Ingress Resource object. 
# This Ingress Resource defines an inbound L7 rule for path /hello to service hello-app on port 8080.

# check frontend app
http://${EXTERNAL_LB_IP}/hello

# check backend
http://${EXTERNAL_LB_IP}/test

# clean up
gcloud container clusters delete ${CLUSTER_NAME}
helm repo remove stable
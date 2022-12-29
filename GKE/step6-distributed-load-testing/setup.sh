# Distributed Load Testing Using Kubernetes

# About
# For this lab the system under test is a small web application deployed to Google App Engine. 
# The application exposes basic REST-style endpoints to capture incoming HTTP POST requests 
# (incoming data is not persisted).
# To model this interaction, you'll use Locust, a distributed, Python-based load testing tool that is 
# capable of distributing requests across multiple target paths. For example, 
# Locust can distribute requests to the /login and /metrics target paths.

# Objectives
# - Define environment variables to control deployment configuration
# - Create a GKE cluster
# - Perform load testing (/login and /metrics of Flask app)
# - Optionally scale up the number of users or extend the pattern to other use cases

# GCP Resources
# - GKE
# - GAE
# - Cloud Build
# - GCS

# Goal
# - Deploy a simple REST-based API (Flask) and Test traffic for this application

# Source: https://cloud.google.com/architecture/distributed-load-testing-using-gke


######### setting up the environment #########

# enable cloud build API
gcloud services enable cloudbuild.googleapis.com compute.googleapis.com containeranalysis.googleapis.com containerregistry.googleapis.com

# setup env vars
REGION=europe-west1
ZONE=${REGION}-b
PROJECT=$(gcloud config get-value project)
CLUSTER=gke-load-test
TARGET=${PROJECT}.appspot.com
SCOPE="https://www.googleapis.com/auth/cloud-platform"

# clone the repo
git clone https://github.com/GoogleCloudPlatform/distributed-load-testing-using-kubernetes
cd distributed-load-testing-using-kubernetes

######### gke cluter setup #########

gcloud container clusters create $CLUSTER \
   --zone $ZONE \
   --scopes $SCOPE \
   --enable-autoscaling --min-nodes "3" --max-nodes "10" \
   --scopes=logging-write,storage-ro \
   --addons HorizontalPodAutoscaling,HttpLoadBalancing

gcloud container clusters get-credentials $CLUSTER \
   --zone $ZONE \
   --project $PROJECT


######### docker image (locust) upload #########

gcloud builds submit --tag gcr.io/$PROJECT/locust-tasks:latest docker-image

gcloud container images list | grep locust-tasks


######### deploy the GAE application #########

# deploy as default app
gcloud app deploy sample-webapp/app.yaml --project=$PROJECT

######### deploy the Locust master and worker nodes #########

# replace the following values
sed -i -e "s/\[TARGET_HOST\]/$TARGET/g" kubernetes-config/locust-master-controller.yaml
sed -i -e "s/\[TARGET_HOST\]/$TARGET/g" kubernetes-config/locust-worker-controller.yaml
sed -i -e "s/\[PROJECT_ID\]/$PROJECT/g" kubernetes-config/locust-master-controller.yaml
sed -i -e "s/\[PROJECT_ID\]/$PROJECT/g" kubernetes-config/locust-worker-controller.yaml

# deploy the locust master and worker nodes
kubectl apply -f kubernetes-config/locust-master-controller.yaml
kubectl get pods -l app=locust-master
kubectl apply -f kubernetes-config/locust-master-service.yaml
kubectl apply -f kubernetes-config/locust-worker-controller.yaml
kubectl get pods -l app=locust-worker

# verify the locust deployment
kubectl get pods -o wide
kubectl get services
kubectl get svc locust-master


######### traffic testing #########
# get external ip
EXTERNAL_IP=$(kubectl get svc locust-master -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
echo http://$EXTERNAL_IP:8089

# open the browser
Number of User: 30
Hatch Rate: 10

# (OPTIONAL) if you want you can scale up
kubectl scale deployment/locust-worker --replicas=20
kubectl get pods -l app=locust-worker

# change the traffic setup in locust
Number of User: 300
Hatch Rate: 10

# check the GAE dashboard

# after the test click stop


######### clean up #########

# disable GAE
App Engine --> Settings --> Disable

# delete GKE cluster
gcloud container clusters delete $CLUSTER --zone $ZONE
   
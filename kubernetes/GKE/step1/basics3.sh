# set a default compute zone
gcloud config set compute/zone europe-west1-b

# create a GKE clsuter
CLUSTER_NAME="my-k8s-cluster"
gcloud container clusters create ${CLUSTER_NAME}

# get auth credentials for the cluster to interact with it
gcloud container clusters get-credentials ${CLUSTER_NAME}

# get the sample code
gsutil cp -r gs://spls/gsp021/* .
cd orchestrate-with-kubernetes/kubernetes
ls

# deploy nginx server & service
kubectl create deployment nginx --image=nginx:1.10.0
kubectl expose deployment nginx --port 80 --type LoadBalancer
kubectl get services


EXTERNAL_IP=34.77.134.247
curl http://${EXTERNAL_IP}:80


        
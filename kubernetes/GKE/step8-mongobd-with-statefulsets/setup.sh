# Cloud Vision API from a Kubernetes Cluster

# Objectives

# - create a k8s cluster, a headless service, and a statefulset
# - create a mongodb replica set
# - scale up and down the mongodb replica set instances


# Source: https://www.qwiklabs.com/focuses/640?parent=catalog

######### setting up the environment #########

REGION="europe-west1"
ZONE="europe-west1-b"
CLUSTER_NAME="hello-world"

# set zone
gcloud config set compute/zone ${ZONE}

# create a gke cluster
gcloud container clusters create ${CLUSTER_NAME} \
    --num-nodes 2 \
    --scopes cloud-platform

# give credentials
gcloud container clusters get-credentials ${CLUSTER_NAME}
kubectl cluster-info


######### create the mongodb #########

# get mongodb replica set/sidecar 
gsutil -m cp -r gs://spls/gsp022/mongo-k8s-sidecar .
cd ./mongo-k8s-sidecar/example/StatefulSet/

# check the storage class setup yaml
cat googlecloud_ssd.yaml

# check mongo-statefulset
cat mongo-statefulset.yaml

# vi monogo-statefulset.yaml and remove the flags
- "--smallfiles"
- "--noprealloc"

# deploy headless servie and the statefulset
kubectl apply -f mongo-statefulset.yaml

# Wait for the MongoDB replica set to be fully deployed
kubectl get statefulset
kubectl get pods
# Wait for all three members to be created before moving on.

# connect to the first replica set member
kubectl exec -ti mongo-0 mongo

# initiate replica set
rs.initiate()

# check the replica set
rs.conf()


######### scaling the mongodb replica set #########

# scale up from 3 to 5
kubectl scale --replicas=5 statefulset mongo
kubectl get pods

# scale down from 5 to 3
kubectl scale --replicas=3 statefulset mongo
kubectl get pods


# using the mongodb replica set
# connection string url
"mongodb://mongo-0.mongo,mongo-1.mongo,mongo-2.mongo:27017/dbname_?"


######### clean up #########

kubectl delete statefulset mongo
kubectl delete svc mongo
kubectl delete pvc -l role=mongo
gcloud container clusters delete "hello-world"

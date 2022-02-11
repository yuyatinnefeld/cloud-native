# set a default compute zone
gcloud config set compute/zone europe-west1-b

# create a GKE clsuter
CLUSTER_NAME="my-cluster"
gcloud container clusters create ${CLUSTER_NAME}

# get auth credentials for the cluster to interact with it
gcloud container clusters get-credentials ${CLUSTER_NAME}


# create a pod
POD_FILE="pods/monolith.yaml"
POD_NAME="monolith"
kubectl create -f ${POD_FILE}
kubectl get pods
kubectl describe pods ${POD_NAME}

# interacting with pods

# open 2nd cloud shell terminal
kubectl port-forward ${POD_NAME} 11111:80

# open 1st terminal and use curl
curl http://127.0.0.1:11111
curl http://127.0.0.1:11111/secure # >> authorization failed

# login (password=password)
curl -u user http://127.0.0.1:11111/login

# get token
TOKEN=$(curl http://127.0.0.1:11111/login -u user|jq -r '.token')
$TOKEN

# access with the Token
curl -H "Authorization: Bearer $TOKEN" http://127.0.0.1:11111/secure

# check the logs
kubectl logs monolith
kubectl logs -f monolith

# run an interactive shell
kubectl exec monolith --stdin --tty -c monolith /bin/sh
ping -c 3 google.com
exit
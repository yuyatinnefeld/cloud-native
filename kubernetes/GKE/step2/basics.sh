# set deafult compute zone
gcloud config set compute/zone europe-west1-b 

# create GKE cluster
CLUSTER_NAME="my-k8s-cluster"
gcloud container clusters create ${CLUSTER_NAME} --num-nodes 5 --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"

# get sample code
gsutil -m cp -r gs://spls/gsp053/orchestrate-with-kubernetes .
cd orchestrate-with-kubernetes/kubernetes

# create deployment auth service
kubectl apply -f deployments/auth.yaml

# confirm setup
kubectl get deployment
kubectl get replicasets  
kubectl get pod

# create deployment hello-deployment
kubectl apply -f deployments/hello.yaml
kubectl apply -f services/hello.yaml

# create frontend deployment
kubectl create secret generic tls-certs --from-file tls/
kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf
kubectl apply -f deployments/frontend.yaml
kubectl apply -f services/frontend.yaml
 
# check frontend service (takes 2-3 min)
kubectl get services frontend
EXTERNAL_IP=35.241.237.18
curl -ks https://${EXTERNAL_IP}

# or use output template of kubectl
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`

# scale up the hello deployment
kubectl explain deployment.spec.replicas
kubectl scale deployment hello --replicas=5
kubectl get pods | grep hello- | wc -l

# scale down the hello deployment
kubectl scale deployment hello --replicas=3
kubectl get pods | grep hello- | wc -l

# Deploy a Web App on GKE with HTTPS Redirect using Lets Encrypt

# Objectives

# - deploy a containerized web app
# - create a NGINX ingress for HTTP to HTTPS redirect
# - install a cert-manager into a cluster to automate getting TLS/SSL certificates
# deploy/modify an ingress with TLS enabled


# Source: https://www.qwiklabs.com/focuses/2771?parent=catalog

######### setting up the environment #########

REGION="europe-west1"
ZONE="europe-west1-b"
CLUSTER_NAME="cl-cluster"

# set zone
gcloud config set compute/zone ${ZONE}

# download the source code
curl -LO https://storage.googleapis.com/spls/gsp269/gke-tls-lab-2.tar.gz
tar zxfv gke-tls-lab-2.tar.gz
cd gke-tls-lab


# allocate a static ip
gcloud compute addresses create endpoints-ip --region ${REGION}
gcloud compute addresses list
MY_STATIC_IP="????"

# create a gke cluster
gcloud container clusters create ${CLUSTER_NAME}

# give credentials
gcloud container clusters get-credentials ${CLUSTER_NAME}
kubectl cluster-info

# set up role-based access controll
kubectl create clusterrolebinding cluster-admin-binding \
--clusterrole cluster-admin --user $(gcloud config get-value account)


######### add helm and install the packege #########

helm repo add stable https://charts.helm.sh/stable

helm repo update

helm install stable/nginx-ingress --set controller.service.loadBalancerIP=$MY_STATIC_IP,rbac.create=true --generate-name


######### deploy hello world app #########

cat configmap.yaml
kubectl apply -f configmap.yaml
cat deployment.yaml
kubectl apply -f deployment.yaml
cat service.yaml
kubectl apply -f service.yaml

# update ingress.yaml
# replace all instances [MY-PROJECT] with your Project ID.
vi ingress.yaml


# apply the ingress
kubectl apply -f ingress.yaml

# test
http://api.endpoints.[MY-PROJECT].cloud.goog


######### set up https #########

# install cert-manager
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/v0.13.0/deploy/manifests/00-crds.yaml

kubectl create namespace cert-manager

helm repo add jetstack https://charts.jetstack.io

helm repo update

helm install \
  cert-manager \
  --namespace cert-manager \
  --version v0.13.0 \
  jetstack/cert-manager

kubectl get pods --namespace cert-manager

export EMAIL="yu.yuyatinnefeld.com"
cat letsencrypt-issuer.yaml | sed -e "s/email: ''/email: $EMAIL/g" | kubectl apply -f-


# update certificate.yaml
# Replace all instances of [MY-PROJECT] with your Project ID:
 vi certificate.yaml

# update ingress-tls-yaml
# Replace all instances of [MY-PROJECT] with your Project ID:
vi ingress-tls.yaml


# apply
kubectl apply -f ingress-tls.yaml

# check
kubectl describe ingress esp-ingress

# verify
https://api.endpoints.[MY-PROJECT].cloud.goog


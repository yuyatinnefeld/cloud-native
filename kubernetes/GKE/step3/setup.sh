# set deafult compute zone
gcloud config set compute/zone europe-west1-b 

# get sample code
gsutil cp gs://spls/gsp051/continuous-deployment-on-kubernetes.zip .
unzip continuous-deployment-on-kubernetes.zip
cd continuous-deployment-on-kubernetes

############## provisioning jenkins ##############

# setup GKE jenkins cluster
CLUSTER_NAME="jenkins-cd"
gcloud container clusters create ${CLUSTER_NAME}  \
--num-nodes 2 \
--machine-type n1-standard-2 \
--scopes "https://www.googleapis.com/auth/source.read_write,cloud-platform"

gcloud container clusters list

# get auth credentials for the cluster to interact with it
gcloud container clusters get-credentials jenkins-cd
kubectl cluster-info

# setup helm
helm repo add jenkins https://charts.jenkins.io
helm repo update

############## configure and install jenkins ##############

# get jenkins custom values
gsutil cp gs://spls/gsp330/values.yaml jenkins/values.yaml

# configure settings with helm CLI (takes a few minutes)
helm install cd jenkins/jenkins -f jenkins/values.yaml --wait

# check pods
kubectl get pods

# configure the Jenkins service account to be able to deploy to the cluster
kubectl create clusterrolebinding jenkins-deploy --clusterrole=cluster-admin --serviceaccount=default:cd-jenkins

# setup port forwarding (port mapping)
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=cd" -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward $POD_NAME 8080:8080 >> /dev/null &
kubectl get svc

############## connect to jenkins ##############

# create an admin password
printf $(kubectl get secret cd-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

# check web preview adn login jenkins account
Cloud Shell > Web Preview > Preview on port 8080
username: admin
password: auto-generated password

# go to application-setup.sh
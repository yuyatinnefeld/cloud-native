# Deploying WordPress on GKE with Persistent Disks and Cloud SQL

# Objectives
# - CKE cluster
# - PV and PVC backed by Persistent Disk
# - Cloud SWL for MySQL instance
# - Deploy WordPress
# - Setup your WordPress blog


# Source
# https://cloud.google.com/kubernetes-engine/docs/tutorials/persistent-disk


######### setting up the GKE environment #########
export PROJECT_ID="yuyatinnefeld-dev"
export ZONE="europe-west1-b"
export CLUSTER_NAME="persistent-disk-tutorial"

gcloud config set compute/zone $ZONE

gcloud services enable container.googleapis.com sqladmin.googleapis.com

# clone the repo
git clone https://github.com/GoogleCloudPlatform/kubernetes-engine-samples
cd kubernetes-engine-samples/wordpress-persistent-disks
WORKING_DIR=$(pwd)

# create a GKE cluster
gcloud container clusters create $CLUSTER_NAME \
    --num-nodes=3 --enable-autoupgrade --no-enable-basic-auth \
    --no-issue-client-certificate --enable-ip-alias --metadata \
    disable-legacy-endpoints=true

# create a pv and a pvc backed by persistent disk
kubectl apply -f $WORKING_DIR/wordpress-volumeclaim.yaml
kubectl get persistentvolumeclaim

######### create a Cloud SQL for MySQL #########

SQL_INSTANCE_NAME=mysql-wordpress-instance
CLOUD_SQL_PASSWORD=$(openssl rand -base64 18)

gcloud sql instances create $SQL_INSTANCE_NAME

export INSTANCE_CONNECTION_NAME=$(gcloud sql instances describe $SQL_INSTANCE_NAME --format='value(connectionName)')

gcloud sql databases create wordpress --instance $SQL_INSTANCE_NAME

gcloud sql users create wordpress --host=% --instance $INSTANCE_NAME --password $CLOUD_SQL_PASSWORD

######### secret setup #########

# service account setup
SA_NAME="cloudsql-proxy"

gcloud iam service-accounts create $SA_NAME --display-name $SA_NAME

SA_EMAIL=$(gcloud iam service-accounts list \
    --filter=displayName:$SA_NAME \
    --format='value(email)')

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --role roles/cloudsql.client \
    --member serviceAccount:$SA_EMAIL

gcloud iam service-accounts keys create $WORKING_DIR/key.json \
    --iam-account $SA_EMAIL

# create secrets for mysql creds
kubectl create secret generic cloudsql-db-credentials \
    --from-literal username=wordpress \
    --from-literal password=$CLOUD_SQL_PASSWORD

# create secrets for service account creds
kubectl create secret generic cloudsql-instance-credentials \
    --from-file $WORKING_DIR/key.json


######### deploy wordpres #########

# replacing the INSTANCE_CONNECTION_NAME environment variable
cat $WORKING_DIR/wordpress_cloudsql.yaml.template | envsubst > $WORKING_DIR/wordpress_cloudsql.yaml

# deploy wordpress sql manifest
kubectl create -f $WORKING_DIR/wordpress_cloudsql.yaml

kubectl get pod -l app=wordpress --watch

# expose the wordrepss service
kubectl create -f $WORKING_DIR/wordpress-service.yaml
kubectl get svc -l app=wordpress --watch

EXTERNAL_IP="35.187.115.206"

curl -i http://$EXTERNAL_IP

# login with the username and password which you previously created


######### clean up #########

kubectl delete service wordpress

watch gcloud compute forwarding-rules list

kubectl delete deployment wordpress

kubectl delete pvc wordpress-volumeclaim

gcloud container clusters delete $CLUSTER_NAME

gcloud sql instances delete $INSTANCE_NAME

gcloud projects remove-iam-policy-binding $PROJECT_ID \
    --role roles/cloudsql.client \
    --member serviceAccount:$SA_EMAIL
  
gcloud iam service-accounts delete $SA_EMAIL


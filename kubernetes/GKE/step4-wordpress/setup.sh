# How to deploy HA wordpress application with GKE

# about
# In this lab you will learn how to configure a highly available application by deploying WordPress 
# using regional persistent disks on Kubernetes Engine. Regional persistent disks provide synchronous replication 
# between two zones, which keeps your application up and running in case there is an outage or failure 
# in a single zone. Deploying a Kubernetes Engine Cluster with regional persistent disks will make your 
# application more stable, secure, and reliable.

# What you'll do
# - Create a regional Kubernetes Engine cluster.
# - Create a Kubernetes StorageClass resource that is configured for replicated zones.
# - Deploy WordPress with a regional disk that uses the StorageClass.
# - Simulate a zone failure by deleting a node.
# - Verify that the WordPress app and data migrate successfully to another replicated zone.

# Source
# https://www.qwiklabs.com/focuses/1050?parent=catalog



######### create a regional k8s engine cluster #########

REGION="europe-west1"
ZONES="europe-west1-b,europe-west1-c,europe-west1-d"
CLUSTER_VERSION=$(gcloud container get-server-config --region ${REGION} --format='value(validMasterVersions[0])')
export CLOUDSDK_CONTAINER_USE_V1_API_CLIENT=false

# enable kubernetes Engine API


# deploy GKE cluster
gcloud container clusters create repd \
  --cluster-version=${CLUSTER_VERSION} \
  --machine-type=n1-standard-4 \
  --region=${REGION}\
  --num-nodes=1 \
  --node-locations=${ZONES}

######### deploying an app with a regional disk #########

# add the stable chart repo to helm
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm repo list

# create the storageclass "repd-west1-b-c-d"

kubectl apply -f - <<EOF
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: repd-west1-b-c-d
provisioner: kubernetes.io/gce-pd
parameters:
  type: pd-standard
  replication-type: regional-pd
  zones: europe-west1-b,europe-west1-c,europe-west1-d
EOF

# verify
kubectl get storageclass

######### create persistent volume claims #########

# create data-wp-repd-mariadb-0 PVC with storageclass = standard

kubectl apply -f - <<EOF
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: data-wp-repd-mariadb-0
  namespace: default
  labels:
    app: mariadb
    component: master
    release: wp-repd
spec:
  accessModes:
    - ReadOnlyMany
  resources:
    requests:
      storage: 8Gi
  storageClassName: standard
EOF

# create wp-repd-wordpress PVC with storageclass = repd-west1-b-c-d

kubectl apply -f - <<EOF
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: wp-repd-wordpress
  namespace: default
  labels:
    app: wp-repd-wordpress
    chart: wordpress-5.7.1
    heritage: Tiller
    release: wp-repd
spec:
  accessModes:
    - ReadOnlyMany
  resources:
    requests:
      storage: 200Gi
  storageClassName: repd-west1-b-c-d
EOF

# verify the result
kubectl get persistentvolumeclaims

######### deploy wordpress #########

# deploy wp chart (storageclass = repd-west1-b-c-d)
helm install wp-repd \
  --set smtpHost= --set smtpPort= --set smtpUser= \
  --set smtpPassword= --set smtpUsername= --set smtpProtocol= \
  --set persistence.storageClass=repd-west1-b-c-d \
  --set persistence.existingClaim=wp-repd-wordpress \
  --set persistence.accessMode=ReadOnlyMany \
  stable/wordpress

# list wordpress pods
kubectl get pods

# create a service load balancer's external IP
while [[ -z $SERVICE_IP ]]; do SERVICE_IP=$(kubectl get svc wp-repd-wordpress -o jsonpath='{.status.loadBalancer.ingress[].ip}'); echo "Waiting for service external IP..."; sleep 2; done; echo http://$SERVICE_IP/admin

# verify the persistent disk result
while [[ -z $PV ]]; do PV=$(kubectl get pvc wp-repd-wordpress -o jsonpath='{.spec.volumeName}'); echo "Waiting for PV..."; sleep 2; done
kubectl describe pv $PV

# open wordpress URL
echo http://$SERVICE_IP/admin

# get a username and pwd
cat - <<EOF
Username: user
Password: $(kubectl get secret --namespace default wp-repd-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)
EOF

# log in with the pwd

######### simulating a zone failure #########

# obtain the current node of the wordpress pod
NODE=$(kubectl get pods -l app.kubernetes.io/instance=wp-repd  -o jsonpath='{.items..spec.nodeName}')
ZONE=$(kubectl get node $NODE -o jsonpath="{.metadata.labels['failure-domain\.beta\.kubernetes\.io/zone']}")
IG=$(gcloud compute instance-groups list --filter="name~gke-repd-default-pool zone:(${ZONE})" --format='value(name)')

# print the result
echo "Pod is currently on node ${NODE}"
echo "Instance group to delete: ${IG} for zone: ${ZONE}"

kubectl get pods -l app.kubernetes.io/instance=wp-repd -o wide

# delete instance group for simulation
gcloud compute instance-groups managed delete ${IG} --zone ${ZONE}

# verify that both the wordpress pod and pv migration to the node that is in the other zone
kubectl get pods -l app.kubernetes.io/instance=wp-repd -o wide

# open the wordpress admin page
echo http://$SERVICE_IP/admin


# clean up
gcloud container clusters delete repd --region=europe-west1

helm repo remove stable
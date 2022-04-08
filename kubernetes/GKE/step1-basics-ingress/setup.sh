# Creating Services and Ingress Resources

## Create a cluster network policy

#01 create a cluster
export my_zone=us-central1-a
export my_cluster=standard-cluster-1
gcloud container clusters create $my_cluster --num-nodes 3 --enable-ip-alias --zone $my_zone --enable-network-policy
gcloud container clusters get-credentials $my_cluster --zone $my_zone

#02 deploy clusterip service and 2 nginx pods
kubectl apply -f dns-demo.yaml
kubectl get pods

# ping dns-demo-2 (from dns-demo-1)
kubectl exec -it dns-demo-1 -- /bin/bash
apt-get update
apt-get install -y iputils-ping
ping dns-demo-2.dns-demo.default.svc.cluster.local -c 3 # pod
ping dns-demo-service.default.svc.cluster.local -c 3 # service

##03 Deploy a sample workload and clusterip  service
kubectl create -f hello-v1.yaml
kubectl get deployments
kubectl get pods
# add the service type
kubectl apply -f ./hello-svc.yaml
kubectl get service hello-svc
# connect http the application (cloud shell)
curl hello-svc.default.svc.cluster.local # result -> cloud not resolve host
# curl in the dns-demo-1 pod
kubectl exec -it dns-demo-1 -- /bin/bash
apt-get install -y curl
curl hello-svc.default.svc.cluster.local

##04 Convert the service to use ClusterIp > NodePort
kubectl apply -f ./hello-nodeport-svc.yaml
kubectl get service hello-svc

# connect http the application (cloud shell)
curl hello-svc.default.svc.cluster.local # result -> cloud not resolve host
# curl in the dns-demo-2 pod
kubectl exec -it dns-demo-2 -- /bin/bash
curl hello-svc.default.svc.cluster.local

##05 Deploy a new set of Pods and LB Service
# 05-1 - create external ip address (regional and global)
EXTERNAL_IP_ADDRESS="regional-loadbalancer"
EXTERNAL_IP_ADDRESS2="global-ingress"
gcloud compute addresses create $EXTERNAL_IP_ADDRESS --project$PROJECT_ID --region=us-central1
gcloud compute addresses create $EXTERNAL_IP_ADDRESS2 --project$PROJECT_ID  --global

# 05-2 - create hello app 2
kubectl create -f hello-v2.yaml
kubectl get deployments

export STATIC_LB=$(gcloud compute addresses describe regional-loadbalancer --region us-central1 --format json | jq -r '.address')
echo $STATIC_LB
sed -i "s/10\.10\.10\.10/$STATIC_LB/g" hello-lb-svc.yaml
cat hello-lb-svc.yaml

# deploy the service
kubectl apply -f ./hello-lb-svc.yaml
kubectl get services

# confirm that a regional GCP LB has been created
# Network Service > Loadbalancer
# if you see a LB with 1 target pool backend & 2 instances than fine
kubectl get service
curl $STATIC_LB

# connect pod
kubectl exec -it dns-demo-2 -- /bin/bash
curl hello-lb-svc.default.svc.cluster.local

##06 Deploy an ingress resource
kubectl apply -f hello-ingress.yaml
kubectl describe ingress hello-ingress
curl http://$STATIC_LB/v1
curl http://$STATIC_LB/v2
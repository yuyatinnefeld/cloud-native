# Deploying Google Kubernetes Engine Clusters from Cloud Shell

## deploy GKE cluster

export my_zone=europe-west1
export my_cluster=standard-cluster-1
gcloud container clusters create $my_cluster --num-nodes 3 --zone $my_zone --enable-ip-alias

# update kubeconfig file credentials
gcloud container clusters get-credentials $my_cluster --zone $my_zone

# verify the configration (kubeconfig file is located in HOME/.kube/config)
cat ~/.kube/config

# print cluster info
kubectl cluster-info

# print out the active context
kubectl config curre

# enable bash autocompletion for kubectl
source <(kubectl completion bash)

# test
kubectl co
kubectl a

## deploy pods to GKE cluster

# create a pod with nginx image
kubectl create deployment --image nginx nginx-pod1
kubectl get pods

# describe
export my_nginx_pod=[your_pod_name]
kubectl describe pod $my_n

# push a file into a container
nano ~/test.html
kubectl cp ~/test.html $my_nginx_pod:/usr/share/nginx/html/test.html

## expose the pod for testing

# create a loadbalancer service for internet address accesssing
kubectl expose pod $my_nginx_pod --port 80 --type LoadBalancer
kubectl get services

# test the page
EXTERNAL_IP=""
curl http://$EXTERNAL_IP/test.html


## deploy pods with yaml manifest file
kubectl apply -f ./new-nginx-pod.yaml

# push a file
# option 1
kubectl get pods
kubectl cp ~/test.html $new_nginx_pod:/usr/share/nginx/html/test.html

# option2: setup in the container
kubectl exec -it new-nginx /bin/bash
apt-get update
apt-get install nano
cd /usr/share/nginx/html
nano test.html
exit

# setup port 10081 to 80 of the nginx
kubectl port-forward new-nginx 10081:80

# verify
curl http://127.0.0.1:10081/test.html

## view logs of a pod
kubectl logs new-nginx -f --timestamps
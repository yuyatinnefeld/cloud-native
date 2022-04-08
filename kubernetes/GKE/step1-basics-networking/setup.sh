# GKE Networking

## Create a cluster network policy

# create a cluster
export my_zone=us-central1-a
export my_cluster=standard-cluster-1
gcloud container clusters create $my_cluster --num-nodes 3 --enable-ip-alias --zone $my_zone --enable-network-policy
gcloud container clusters get-credentials $my_cluster --zone $my_zone

# deploy hello app
kubectl run hello-web --labels app=hello \
  --image=gcr.io/google-samples/hello-app:1.0 --port 8080 --expose

# create an ingress policy
kubectl apply -f hello-allow-from-foo.yaml

# verify
kubectl get networkpolicy

## validate the ingress policy

# run a pod (foo) to test the access
kubectl run test-1 --labels app=foo --image=alpine --restart=Never --rm --stdin --tty

# make a request
wget -qO- --timeout=2 http://hello-web:8080

# create a pod (other)
kubectl run test-1 --labels app=other --image=alpine --restart=Never --rm --stdin --tty
# try to access
wget -qO- --timeout=2 http://hello-web:8080

## restrict outgoing traffic from the pods

kubectl apply -f foo-allow-to-hello.yaml
kubectl get networkpolicy

# deploy a new app
kubectl run hello-web-2 --labels app=hello-2 \
  --image=gcr.io/google-samples/hello-app:1.0 --port 8080 --expose

# test
kubectl run test-3 --labels app=foo --image=alpine --restart=Never --rm --stdin --tty
wget -qO- --timeout=2 http://hello-web:8080
wget -qO- --timeout=2 http://hello-web-2:8080
wget -qO- --timeout=2 http://www.google.com

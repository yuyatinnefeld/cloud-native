# Deploying Google Kubernetes Engine Clusters from Cloud Shell

## deploy GKE cluster

export my_zone=europe-west1
export my_cluster=standard-cluster-1
gcloud container clusters create $my_cluster --num-nodes 3 --zone $my_zone --enable-ip-alias

# update kubeconfig file credentials
gcloud container clusters get-credentials $my_cluster --zone $my_zone

# create and run jobs
kubectl apply -f bash-job.yaml
kubectl apply -f perl-job.yaml
kubectl get job
kubectl describe job  simple-bash-job

# view all pod resources
kubectl get pods

# show the results
kubectl logs simple-bash-job-dpmnk
kubectl logs bash-job-pw5j2

# create a job with cron scheduling
vi example-cronjob.yaml
kubectl get pod
kubectl log $POD_ID

# clean up
kubectl delete cronjob hello
kubectl delete cronjob simple-bash-job
kubectl delete cronjob example-perl-job
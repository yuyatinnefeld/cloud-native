# 1 create namespace
kubectl create namespace flask-postgresql
kubens flask-postgresql

# 2 create config map
kubectl apply -f k8s/config-map.yaml 


# 3 create storage volume
kubectl apply -f k8s/storage.yaml
kubectl get persistentvolumeclaim
kubectl get persistentvolume

# 4 create pods & service
kubectl apply -f k8s/postgres.yaml
kubectl describe deployment postgres-deployment
kubectl get all


# 5 connect to postgresql
minikube ip
export HOST="192.168.64.3" #here minikube ip
export PASSWORD="pwd"
export USERNAME="admin"

kubectl describe service k8s/postgres-service
# We need to use port 30001 (nodePort) to connect to PostgreSQL from machine/node

kubectl run postgresql-postgresql-client --rm --tty -i --restart='Never' \
    --namespace flask-postgresql \
    --image bitnami/postgresql \
    --env="PGPASSWORD=${PASSWORD}" \
    --command -- psql -h ${HOST} -U ${USERNAME} --password -p 30001 postgresdb


# 6 coming soon








# clean up
kubectl delete pvc --all
kubectl delete persistentvolume postgres-pv-volume
kubectl delete pods --all
kubectl delete services --all
kubectl delete deployments --all
kubectl delete secrets --all
kubectl get all
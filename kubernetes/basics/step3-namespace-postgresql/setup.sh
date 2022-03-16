# 1 create a new namespace
kubectl create namespace postgres-namespace
kubectl get namespace

# 2 install kubens and change the default namespace for the team
brew install kubectx

# 3 change the default namespace
kubens postgres-namespace
kubens

# 4 create config map
kubectl apply -f config-map.yaml 

# 5 create storage volume
kubectl apply -f storage.yaml

# 6 create pods & service
kubectl apply -f postgres.yaml 

# 7 check port for the postgres conn
kubectl describe service postgres-service
# We need to use port 30001 (nodePort) to connect to PostgreSQL from machine/node

# 8 connect postgres (option 1)
brew install postgresql
brew services start postgresql
minikube ip
vi /etc/hosts
192.168.64.2    postgres-host
psql -h postgres-host -U admin --password -p 30001 postgresdb

# 9 connect postgres (option 2)
minikube ip
export HOST="192.168.64.8" #here minikube ip
export PASSWORD="pwd"
export USERNAME="admin"

kubectl describe service postgres-service
# We need to use port 30001 (nodePort) to connect to PostgreSQL from machine/node

kubectl run postgresql-postgresql-client --rm --tty -i --restart='Never' \
    --namespace postgres-namespace \
    --image bitnami/postgresql \
    --env="PGPASSWORD=${PASSWORD}" \
    --command -- psql -h ${HOST} -U ${USERNAME} --password -p 30001 postgresdb

# 10 clean up
brew services stop postgresql
brew uninstall postgresql
rm -rf /usr/local/var/postgres
rm /usr/local/var/log/postgres.log
rm -f ~/.psqlrc ~/.psql_history

kubectl delete service postgres-service 
kubectl delete deployment postgres-deployment
kubectl delete configmap postgres-config
kubectl delete persistentvolumeclaim postgres-pv-claim
kubectl delete persistentvolume postgres-pv-volume
kubens my-namespace
kubectl delete namespaces postgres-namespace

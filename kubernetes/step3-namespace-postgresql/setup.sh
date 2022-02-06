# 1 create a new namespace
kubectl create namespace my-namespace
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

# 7 connect to postgresql
kubectl describe service postgres-service
# We need to use port 30001 (nodePort) to connect to PostgreSQL from machine/node

# 8 install psql
brew install postgresql
brew services start postgresql

# 9 add postgres-host and minikube ip in host mapping list
vi /etc/hosts
192.168.64.2    postgres-host
psql -h postgres-host -U admin --password -p 30001 postgresdb

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

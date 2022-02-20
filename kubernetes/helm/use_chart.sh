# change the namespace
kubectl create namespace mongodb
kubens mongodbkubens mongodb
kubens

# add repo
helm repo add bitnami https://charts.bitnami.com/bitnami

# install mongodb
helm install mongodb-release bitnami/mongodb 

# get pwd
export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace mongodb mongodb-release -o jsonpath="{.data.mongodb-root-password}" | base64 --decode)

# connect to the db
kubectl run --namespace mongodb mongodb-release-client --rm --tty -i --restart='Never' --env="MONGODB_ROOT_PASSWORD=$MONGODB_ROOT_PASSWORD" --image docker.io/bitnami/mongodb:4.4.12-debian-10-r12 --command -- bash

# then run the following command:
mongo admin --host "mongodb-release" --authenticationDatabase admin -u root -p $MONGODB_ROOT_PASSWORD

# check the tables
show collections

# create a new schame / database
use test-schema
show collections
show dbs
db

# create a new collection
# db.createCollection(name, options)
db.createCollection("hello-world-table")

db.user_group.insert({"marketing":"seo", "gender" : "female", "revenue" : 6142800, "city" : "cologne"})

db.employeeprofile.insert({
   emp_name: "Pradeep",
   emp_age:  23,
   emp_website: "employeeprofile.com"
})

# describe details
db.getCollectionInfos()
db.employeeprofile.find().pretty();
db.user_group.find().pretty();

# delete table
db.employeeprofile.drop()
db.user_group.drop()
show collections


# To connect to your database from outside the cluster execute the following commands:
kubectl port-forward --namespace mongodb svc/mongodb-release 27017:27017 &
mongo --host 127.0.0.1 --authenticationDatabase admin -p $MONGODB_ROOT_PASSWORD

# clean up
helm delete mongodb-release 
kubectl get pods
kubens default
kubectl delete namespace mongodb
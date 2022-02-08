# 1 create mongoDB pod
MONOG_DEPLOYMENT_FILE="mongo.yaml"
vi mongodb/${DEPLOYMENT_FILE}

# 2 secret setup (user, pwd)
vi secret.yaml

# 3 create encrypted secret values and paste in secret.yaml
echo -n 'yuya' | base64
eXV5YQ==

echo -n 'password' | base64
cGFzc3dvcmQ=

# 4 create secrets
kubectl apply -f secret.yaml
kubectl get secret

# 5 update the secret setup in depl.yaml
vi ${MONOG_DEPLOYMENT_FILE}
kubectl apply -f ${MONOG_DEPLOYMENT_FILE}

# 6 create service
vi ${MONOG_DEPLOYMENT_FILE}
kubectl apply -f ${MONOG_DEPLOYMENT_FILE}
kubectl get service
kubectl describe service mongodb-service

# 7 create mongo-express deployment
kubectl apply -f config-map.yaml
MONGO_EXPRESS_DEPLOYMENT_FILE="mongo-express.yaml"
kubectl apply -f ${MONGO_EXPRESS_DEPLOYMENT_FILE}

ME_POD_NAME="mongo-express-65b9f4495f-cvdjm"
kubectl logs ${ME_POD_NAME}

# 8 assign external ip for mongo-express-service
minikube service mongo-express-service
|-----------|-----------------------|-------------|---------------------------|
| NAMESPACE |         NAME          | TARGET PORT |            URL            |
|-----------|-----------------------|-------------|---------------------------|
| default   | mongo-express-service |        8081 | http://192.168.64.2:30000 |
|-----------|-----------------------|-------------|---------------------------|

# 9 clean up
kubectl delete pods --all
kubectl delete services --all
kubectl delete deployments --all
kubectl delete secrets --all
kubectl get all

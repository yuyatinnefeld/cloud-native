
# create deployment
DEPL_FILE_NAME="nginx-deployment.yaml"
touch ${DEPL_FILE_NAME}
kubectl apply -f ${DEPL_FILE_NAME}

# create service
S_FILE_NAME="nginx-service.yaml"
SERVICE_NAME="nginx-service"
touch ${S_FILE_NAME}
kubectl apply -f ${S_FILE_NAME}
kubectl get service

# check the Endpoints
kubectl get pod -o wide
kubectl describe service ${SERVICE_NAME}

# check the status in the yaml
kubectl get deployment nginx-deployment -o yaml > nginx-depl-result

# delete 
kubectl delete -f ${DEPL_FILE_NAME}
kubectl delete -f ${S_FILE_NAME}

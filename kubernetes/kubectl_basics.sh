#!/bin/bash

# Keywords

# Checkt the status
kubectl get nodes
kubectl get pod
kubectl get services
kubectl get replicaset
kubectl get deployment

# CRUD commands
kubectl create deployment ${DEPLOYMENT_NAME} --image=image
kubectl edit deployment ${DEPLOYMENT_NAME}
kubectl delete deployment ${DEPLOYMENT_NAME}

# Debug
kubectl logs ${POD_NAME}
kubectl exec -it ${POD_NAME} --bin/bash

# CREATE/UPDATE DEPLOYMENT WITH YAML
kubectl apply -f ${FILE_NAME}

# EXAMPLE
DEPLOYMENT_NAME="nginx-depl"
IMAGE="nginx"
kubectl create deployment ${DEPLOYMENT_NAME} --image=${IMAGE}
kubectl get deployment
kubectl get pod
kubectl edit deployment ${DEPLOYMENT_NAME}
kubectl create deployment ${DEPLOYMENT_NAME} --image=nginx

DEPLOYMENT_NAME="mongo-depl"
IMAGE="mongo"
kubectl create deployment ${DEPLOYMENT_NAME} --image=${IMAGE}

POD_NAME=mongo-depl-5fd6b7d4b4-4nh86
kubectl logs ${POD_NAME}
kubectl describe pod ${POD_NAME}
kubectl exec -it ${POD_NAME} -- bin/bash
kubectl delete deployment ${DEPLOYMENT_NAME}

FILE_NAME="nginx-deployment.yaml"
touch ${FILE_NAME}
kubectl apply -f ${FILE_NAME}
kubectl delete -f ${FILE_NAME}

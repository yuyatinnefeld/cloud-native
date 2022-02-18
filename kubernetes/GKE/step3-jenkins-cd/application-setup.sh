############## intro ##############

# logic of the application (name=gceme)
# backend: listens on port 8080 and returns Compute Engine instance metadata in JSON format.
# frontend: queries the backend service and renders the resulting JSON in the user interface.
# User > LB > Frontend Pod > Backend Service > Backend Pod

############## deploying the application ##############

# go to a application dir
cd sample-app

# create a new namespace
kubectl create ns production

# create production and canary deployments and service
kubectl apply -f k8s/production -n production
kubectl apply -f k8s/canary -n production
kubectl apply -f k8s/services -n production

############## testing ##############

# scale up the production (frontend)
kubectl scale deployment gceme-frontend-production -n production --replicas 4

# check the setup
kubectl get pods -n production -l app=gceme -l role=frontend
kubectl get pods -n production -l app=gceme -l role=backend

# retrieve the external ip
kubectl get service gceme-frontend -n production

# paste external IP into a browser to see the info card displayed on a card—you should get a similar page

# get frontend service load balancer ip
export FRONTEND_SERVICE_IP=$(kubectl get -o jsonpath="{.status.loadBalancer.ingress[0].ip}" --namespace=production services gceme-frontend)


# confirm that both services are working
curl http://$FRONTEND_SERVICE_IP/version

# go to create-pipeline.sh
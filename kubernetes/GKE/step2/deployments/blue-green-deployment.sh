# A major downside of blue-green deployments is that you will need to have at least 2x the resources 7
# in your cluster necessary to host your application. Make sure you have enough resources in your cluster 
# before deploying both versions of the application at once.

# deployment hello-blue
kubectl apply -f services/hello-blue.yaml


# confirm the deployment (version:1.0.0 to version:2.0.0)
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version

# rollabck (2.0.0 to 1.0.0)
kubectl apply -f services/hello-blue.yaml
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version
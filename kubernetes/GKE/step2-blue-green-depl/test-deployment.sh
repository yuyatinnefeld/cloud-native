# to run test deployment we will use hello-canary.yaml
kubectl apply -f deployments/hello-canary.yaml
kubectl get deployments

# confirm the deployment 
#Run this several times and you should see that some of the requests are served by hello 1.0.0 and a small subset (1/4 = 25%) are served by 2.0.0.
curl -ks https://`kubectl get svc frontend -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version
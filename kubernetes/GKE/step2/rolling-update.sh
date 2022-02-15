# setup ./step2/basics.sh

# change the image version to kelseyhightower/hello:2.0.0
kubectl edit deployment hello

# check if the update is automatically doing
kubectl get replicaset
kubectl rollout history deployment/hello    
kubectl rollout status deployment/hello

# rollback
kubectl rollout undo deployment/hello
kubectl rollout history deployment/hello
kubectl get pods -o jsonpath --template='{range .items[*]}{.metadata.name}{"\t"}{"\t"}{.spec.containers[0].image}{"\n"}{end}'
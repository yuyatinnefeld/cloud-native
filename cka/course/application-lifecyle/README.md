# Rolling Updates

```bash

# create deployment
kubectl create -f deployment-definiction.yaml

# rollout
kubectl apply -f deployment-definition.yaml

# check
kubectl rollout status deployment/myapp-deployment
kubectl rolllout histroy deployment/myapp-deployment

# rollout
kubectl rollout undo deployment/myapp-deployment
```

```bash
# ENTRYPOINT ( = command) and CMD (= args)
kubectl create -f ubuntu-sleeper.yaml

# overwrite arguments
kubectl run nginx --image=nginx -- <arg1> <arg2> <arg3>

# overwrite command option
kubectl run nginx --image=nginx --command  -- <cmd> <arg1> <arg2>

```

# Environment

```bash
# config map (inmperative way)
kubectl create configmap <CONFIG-NAME> --from-literal=<KEY>=<VALUE>
# example
kubectl create configmap app-config --from-literal=APP_COLOR=blue --from-literal=APP_MODE=prod

# config map with file
kubectl create config app-config --from-file=app_config.properties

```
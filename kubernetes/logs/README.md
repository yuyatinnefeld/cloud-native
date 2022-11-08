## setup

```bash
# create events
kubectl create -f event-simulator.yaml

# monitor logs
kubectl logs -f event-simulator-pod event-simulator-container-123


# stop events
kubectl delete -f event-simulator.yaml
```

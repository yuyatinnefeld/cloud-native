# kustomize

## about
Kustomize is a tool for customizing Kubernetes configurations. It has the following features to manage application configuration files: generating resources from other sources. setting cross-cutting fields for resources.

## helm vs kustomize
- kustomize: easy to learn
- kustomize: easy to customize config
- helm: great to standardize with template
- helm: easy to manage

## run
```bash
# show kustomize dev
kubectl kustomize myapp/overlays/dev

# show kustomize prod
kubectl kustomize myapp/overlays/prod

# deploy pods and service with the dev setup
kubectl apply -k myapp/overlays/dev
kubectl get pods
kubectl get service

# clean up
kubectl delete -k myapp/overlays/dev

```

## Details
https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/
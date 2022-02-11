# guilde
https://devopscube.com/persistent-volume-google-kubernetes-engine/

# create storage class
kubectl apply -f storage-class.yaml

# create persistent volume claim
kubeactl apply -f pvc.yaml

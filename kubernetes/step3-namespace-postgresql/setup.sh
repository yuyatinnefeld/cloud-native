# 1 create a new namespace
kubectl create namespace my-namespace
kubectl get namespace

# 2 use the namespace in the YAML 
vi config-map.yaml

or

# 2 install kubens and change the default namespace for the team
brew install kubectx

# 3 check the default namespace
kubens

# 4 change the default namespace
kubens my-namespace
kubens

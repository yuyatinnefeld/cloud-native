# FastAPI + k8s

# Normally you will use the Cloud LoadBalancer (GCP, AWS, etc.) For the testing I'll use minikube 

# 0 create docker image and push into your repo
minikube addons disable ingress
docker build -t yuyatinnefeld/fastapi .
docker run -it -p 8080:8080 yuyatinnefeld/fastapi
docker push yuyatinnefeld/fastapi

# 1 kubectl create instance
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml

# check ip 
minikube ip

# 2 add helloworld.test and minikube ip in host
vi /etc/hosts
192.168.64.2    helloworld.test

# 3 activate ngix controller and apply ingress
minikube addons enable ingress
kubectl apply -f ingress.yaml

# 4 check the ingress
kubectl get ingress

# 5 open the URLs
http://helloworld.test
http://helloworld.test/docs

# 6 check the logs
kubectl describe pod helloworld-7767c4dd-ckntl
kubectl logs helloworld-7767c4dd-ckntl

# 7 cleanup
kubectl delete ingrsess --all
vi /etc/hosts
kubectl delete pods --all
kubectl delete services --all
kubectl delete deployments --all
kubectl delete secrets --all
kubectl get all

kubens
minikube addons disable ingress
kubens
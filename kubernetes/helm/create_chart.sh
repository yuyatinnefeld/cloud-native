# source: https://opensource.com/article/20/5/helm-charts

# create dummy chart
helm create yt-chart

# check the chart
ls yt-chart/


# edit variables
vi values.yaml

# deploy my custom chart
helm install hello-hello-chart yt-chart/ --values yt-chart/values.yaml 

export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services yt-hello-chart)
export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
echo http://$NODE_IP:$NODE_PORT

# clean up
helm list
helm uninstall hello-hello-chart

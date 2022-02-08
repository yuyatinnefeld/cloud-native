# helm = package manager for k8s
# helm chart = bundle of YAML files (k8s package)

# public repo (helm saerch hub)
https://helm.sh/docs/helm/helm_search_hub/

helm search <keyword>

# private repo (kubeapps)
https://docs.bitnami.com/tutorials/custom-app-private-repo-kubeapps/

# structure
mychart/
    chart.yaml
    values.yaml
    charts/
    templates/

# create /upgrade/reset helm chart
helm install <chart name>
helm upgrade <chart name>
helm rollback <chart name>

# release management
server: tiller
client: helm CLI
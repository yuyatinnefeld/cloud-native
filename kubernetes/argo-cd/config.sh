# gitlab (public access)
mkdir argocd-app-config && cd argocd-app-config
mkdir dev
touch dev/deployment.yaml
touch dev/service.yaml
git init
git add .
git commit -m "initial setup"
git remote add gitlab git@gitlab.com:argocd-app-config.git
git push gitlab master

# create application.yaml
touch application.yaml

# commit
git add .
git commit -m "feat: add application config yaml"
git push gitlab master

# connect argocd with the git repo
kubectl apply -f application.yaml
############## create pipeline ##############

# setup cloud source repo (VCS for GCP)
gcloud source repos create default
git init
git config credential.helper gcloud.sh
git remote add origin https://source.developers.google.com/p/$DEVSHELL_PROJECT_ID/r/default
git config --global user.email "yuya.tinnefeld.com"
git config --global user.name "yuya.tinnefeld"

# git commit
git add .
git commit -m "Initial commit"
git push origin master


############## adding your service account credentials ##############

#1 Jenkins > Manage Jenkins > Manage Jenkins Credentials > Click Jenkis (Store)

#2 Add Credentials > Google Service Account from metadata

#3 Jenkins Job > New Item
name: sample-app
type: Multibranch Pipeline
navi: Branch sources
add source: git

PROJECT_ID=qwiklabs-gcp-01-a33704e89fd2
repo: https://source.developers.google.com/p/[PROJECT_ID]/r/default
repo: https://source.developers.google.com/p/qwiklabs-gcp-01-a33704e89fd2/r/default

select credentials

interval=1min

############## createing the dev branch ##############

git checkout -b new-feature
vi Jenkinsfile
# Add your PROJECT_ID to the REPLACE_WITH_YOUR_PROJECT_ID value. 
vi html.go
#change
#<div class="card blue"> to <div class="card orange">
vi main.go
# const version string = "1.0.0" to const version string = "2.0.0"

git add Jenkinsfile html.go main.go
git commit -m "Version 2.0.0"
git push origin new-feature

# check jenkins build action


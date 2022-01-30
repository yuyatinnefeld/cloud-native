# Jupyternotebook Lab

## Setup
1. adjust the token username and password in the docker-compose.yml

2. the docker volumes are stored in your local forder
```bash
# macbook
screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty

# check the volume data
docker volume ls

# clean up the volumes
docker volume prune

docker volume rm <jupyterlab-volume-data-name>
```


# Docker Storage & volume

## Issues with storing docker data
- contaienr are designed to be ephemeral
- when containers are stopped, data is not accesible
- container are typically stored on each host (not possbile share data)

## Solution for data storing with docker
- Volumes (Most recommended)
    - data stored at /var/lib/docker/volumes
- Bind Mount
    - exact file path on the host
- Tmpfs Mount
    - not recommended. only for linux

## Block vs object storage

### Block
- fixed chunks of data
- no metadata is stored
- best for I/= intensive apps
- SAN storage uses block storage protocols like iSCSI
- transactional data

### Object
- data is stored with metadata and a unique identifier
- there is no organization or hierarchie to the objects
- scalability is limitless
- accessed with HTTP calls
- shared semi-static files
- Aws S3

## Docker layered storage
- docker uses storage drivers to manage image layers and the writable container layer
- each storage driver handles the implementation differently
- all drivers uses stackable image layers
- all drivers uses the COW strategy

## docker storage drivers

### storage driver types
- overlay2 / overlay: default choice for Docker CE, works file level

- devicemapper: direct-lvm, works block level, only supported for:
    - Docker EE
    - Docker CS-Engine on RHEL, CentOS, Orcale Linux
    - Docker CE on CentOS, Fedora, Ubuntu or Debian

- aufs
- btrfts
- zfs

### !! driver change !!
when you change the storage dirver, any existing images nad containers become inaccessible

### how to change storage driver

```bash
# check storage driver
docker info | grep 'Storage Driver'

# stop docker
sudo systemctl stop docker

# copy docker folder backup
sudo cp -au /var/lib/docker /var/lib/docker.bk

# edit daemon.json
sudo vi /etc/docker/daemon.json

# option 1
{
    "storage-driver": "overlay"
}

# option 2
{
    "experimental":true
    "storage-driver": "devicemapper"
}


# restart docker
sudo systemctl start docker
```

## docker volumes
```bash
# see volumes
docker volume ls

# create a volume
docker volume create my-vol

# inspect volume
docker volume inspect my-vol

# remove volume
docker volume rm my-vol

# start nginx container wiht a new volume
docker run -d \
    --name testvol \
    -v my-vol:/app \
    nginx:latest

# start nginx container wiht a new volume
$ docker run -d \
    --name=testvol \
    --mount source=my-vol,target=/app \
    nginx:latest

# checkt the container relation
docker container inspect  <container id> | grep 'Source'
```



docker bind mount (not recommended)
```bash
# start nginx container wiht a new volume
docker run -d \
    --name testvol \
    -v "$(pwd)"/target:/app \
    nginx:latest

# start nginx container wiht a new volume
$ docker run -d \
    --name=testvol \
    --mount type=bind,source="$(pwd)",target=/app \
    nginx:latest


```
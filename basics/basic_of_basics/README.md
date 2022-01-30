 ## container

```bash
# define container name
docker run --name <Custom Container Name> <Image Name>

# rename container name
docker rename <Old Container Name> <New Container Name>

# start container
docker container start <Container ID or Name>

# stop container
docker container stop <Container ID or Name>
```


docker container run in the limited time
```bash
docker run --rm -ti ubuntu sleep 5

docker run --rm -ti ubuntu bash -c "sleep 3; echo done"
```

## interactive docker shell

use terminal in the container

```bash
docker exec -it <Container Name> sh
# executiong commands
# life time: Container Lifetime

docker run -ti <Image Name> bash
# terminal interactive
# life time: Terminal Session
```

## image

```bash
# show image list
docker images

# import docker image
docker pull <Image Name>

# update docker image
docker commit <Container Name or ID>

# use a customized image
docker tag <Imge ID> <Custom Image Name>

# create a new image
docker commit <Container Name or ID> <Custom Image Name>[<Version-Tag>]

# delete image
docker rmi <Image ID or Image Name:Tag>
```

## volumes / storage
volumes: virutal "discs" to store and share data
two main varieties:
- persistent
- ephemeral


### shararing data with the host
```bash
# create a local direcotry
mkdir example

# connect example dir with the docker directory shared-folder
docker run -ti -v /home/ytubuntu/yu/docker/example:/shared-folder ubuntu bash

# create a few files
root@7faae0fa2d2a:/# touch /shared-folder/my-data1
root@7faae0fa2d2a:/# touch /shared-folder/my-data2

# check the example dir
ls example
```

### shararing data between contaienrs
```bash
# use volumes-from / shared discs life time = container life time
docker run -ti -v /shared-data ubuntu bash
root@0d189768d6aa:/# echo hello > /shared-data/data-file
root@0d189768d6aa:/# echo hello123 > /shared-data/data123-file

# use the exist container name
docker run -ti --volumes-from <Container Name> ubuntu bash
root@f3d0af0c74b4:/# ls shared-data
```

### unix storae in brief
- actual storage devices 
- locgical storage devices
- filesystems
- FUSE filesystems and network fielsystems

### volumes and bind mounting
- VFS (Linux Virtual File System)
- Mounting devices on the VFS
- Mounting direcotries on the VFS

```bash
docker run -ti --rm --privileged=true ubuntu bash
root@f305c06c0ac1:/# mkdir example
root@f305c06c0ac1:/# cd example
root@f305c06c0ac1:/example# cd work
root@f305c06c0ac1:/example/work# touch a b c d e f
root@f305c06c0ac1:/example/work# ls
a  b  c  d  e  f
root@f305c06c0ac1:/example/work# cd ..
root@f305c06c0ac1:/example# mkdir other-work
root@f305c06c0ac1:/example# cd other-work
root@f305c06c0ac1:/example/other-work# touch other-a other-b other-c other-d
root@f305c06c0ac1:/example/other-work# ls
other-a  other-b  other-c  other-d
root@f305c06c0ac1:/example/other-work# cd ..
root@f305c06c0ac1:/example# ls -R
.:
other-work  work

./other-work:
other-a  other-b  other-c  other-d

./work:
a  b  c  d  e  f
root@f305c06c0ac1:/example# 
```

Mounting work directory
```bash
# mount the directory
root@f305c06c0ac1:/example# mount -o bind other-work work
root@f305c06c0ac1:/example# ls -R
.:
other-work  work

./other-work:
other-a  other-b  other-c  other-d

./work:
other-a  other-b  other-c  other-d

# back before mount
root@cfed6bc6a347:/example# umount work 
root@cfed6bc6a347:/example# ls -R
.:
other-work  work

./other-work:
oa  ob  oc  od  oe  of

./work:
a  b  c  d  e  f

```



## logs
check the outputs

```bash
# create error cmd
docker run --name MyContainer -d ubuntu bash -c "lose /etc/password"

# check the output
docker logs MyContainer

```

## export ports
terminal 1
```bash
docker run --rm  -ti -p 45678:45678 -p 45679:45679 --name echo-server ubuntu bash
apt-get update
apt-get install ncat
root@83cccd2762b4:/# nc -lp 45678 | nc -lp 45679
```
terminal 2
```bash
docker port echo-server 
23333/tcp -> 0.0.0.0:49154
23333/tcp -> :::49154
35555/tcp -> 0.0.0.0:49153
35555/tcp -> :::49153

```

```bash
nc localhost 49154
hallo
hey terminal

```

terminal 3 (message displayed)
```bash
nc localhost 49153
```

## Network
create network
```bash
docker network create ytnetwork
docker network ls
docker run --rm -ti --net ytnetwork --name catserver ubuntu bash
apt-get update
apt install iputils-ping
ping catserver
``` 

## registry / docker hub
```bash
# search images
docker search ubuntu

# login docker hub
docker login

# import debian image
docker pull debian:sid

# create a cutom image
docker tag debian:sid yuyasdocker/test-img-34:v99.9

# push the image into your docker hub
docker push yuyasdocker/test-img-34:v99.9
``` 

## inspect process
```bash
docker run -ti --rm --name hello ubuntu bash
docker inspect --format '{{.State.Pid}}' hello
4989
``` 

```bash
docker run -ti --rm --name hello ubuntu bash
docker run -ti --rm --privileged=true --pid=host ubuntu bash
root@9dfa10b21632:/# kill 4989
```

## resource limitation
- scheduling CPU time
- memory allocation limits
- inherited limiations and quotas


## saving and loading containers

```bash
# saving images as gz file

$ docker images
REPOSITORY                TAG       IMAGE ID       CREATED          SIZE
my-busybox                latest    cfaf583fa36c   21 seconds ago   1.24MB
docker-ansible_ansible    latest    fd8348026151   4 days ago       392MB
docker-ansible_target04   latest    b38c193bbf2e   5 days ago       492MB
docker-ansible_target5    latest    b38c193bbf2e   5 days ago       492MB
docker-ansible_target01   latest    b38c193bbf2e   5 days ago       492MB
docker-ansible_target02   latest    b38c193bbf2e   5 days ago       492MB
docker-ansible_target03   latest    b38c193bbf2e   5 days ago       492MB
ubuntu                    latest    1318b700e415   7 days ago       72.8MB
amazonlinux               latest    add9612f9214   2 weeks ago      164MB

$ docker save -o my-images.tar.gz my-busybox:latest ubuntu:latest amazonlinux:latest
```

```bash
# loading
docker rmi my-busybox:latest ubuntu:latest amazonlinux:latest

docker load -i my-images.tar.gz

```

## docker information

docker setup info
```bash
docker system info
```

docker size info
```bash
docker system df
```
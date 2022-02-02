# Docker Network

## Network Drivers Type

### Bridge Network Drivers
- connect container to the LAN and other containers
    - default network type
    - great for most use cases

### Host Network Drivers
- remove network isolation between container and host
    - only one container can use a port at the same time
    - userful for specific applications, such as a management contaienr that you want to run on every host

### Overlay Network Drivers
- connect multiple Docker hosts and their containers together
    - only available with Docker EE and Swarm enabled
    - multihost networking using VXLAN

### Macvlan Network Drivers
- assign a MAC address, appear as physical host
    - clones host interfaces to create virutal interfaces, available in the container
    - supports connecting to VLANs

### None Network Drivers
- connects the container to an isolated network with only that container on it
    - container cannot communicate with any other networks or networked devices

### Third Party Networking Plugins (Docker Store)
- Infobox IPAM plugin
- Weave Net
- Contiv Network plugin
- etc.


```bash
# see networks
docker network ls

# check details
docker network inspect bridge

# create a network (e.g. app-net)
docker network create --driver bridge app-net

# run 2 containers with the app-net network
docker run --rm -dit --name app1 --network app-net alpine:latest ash
docker run --rm -dit --name app2 --network app-net alpine:latest ash

# check the running containers
$ docker ps
CONTAINER ID   IMAGE           COMMAND   CREATED          STATUS          PORTS     NAMES
cfccb4490355   alpine:latest   "ash"     7 seconds ago    Up 6 seconds              app2
f850ad9ef916   alpine:latest   "ash"     33 seconds ago   Up 32 seconds             app1

```

these containers can communicate each other
```bash
docker container attach app1
/ # 
/ # ping app2
PING app2 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.191 ms
64 bytes from 172.18.0.3: seq=1 ttl=64 time=0.082 ms
64 bytes from 172.18.0.3: seq=2 ttl=64 time=0.146 ms
64 bytes from 172.18.0.3: seq=3 ttl=64 time=0.146 ms


$ docker container attach app2
/ # 
/ # ping app1
PING app1 (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.056 ms

# stop the containers
docker container stop app1 app2

# delete the network
docker network rm app-net

```

## PORT

### docker run with the port

```bash
# run nginx container with the exact port => localhost:8080
docker run -it --rm -d -p 8080:80 --name web1 nginx

# run nginx container with the expose port  => localhost:49153
docker run -it --rm -d -P --name web2 nginx

# check the port number (49153)
docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                     NAMES
30434b4d288d   nginx     "/docker-entrypoint.…"   7 seconds ago   Up 5 seconds   0.0.0.0:49153->80/tcp, :::49153->80/tcp   web2
6f30078157c4   nginx     "/docker-entrypoint.…"   3 minutes ago   Up 2 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp     web1

```

## port type

#### comparting host publishing (Host port publishing)
- is used with a global mode service
- is used to publish a single port on each host

#### ingress port publishing
- is used with replicated mode service
- is used to publish a sigle port across all host that goes to a pool of containers


### Host Network

```bash
docker run --rm -d --network host --name app123 nginx
```
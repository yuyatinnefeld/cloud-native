```bash
# setup env
USER_NAME=yuyatinnefeld
IMAGE_NAME=go-hello-world:v1.0.0

# build image
docker build -t $USER_NAME/$IMAGE_NAME .

# create and test container
CONTAINER_NAME=my-running-app
docker run -it --rm --name $CONTAINER_NAME $USER_NAME/$IMAGE_NAME 

# option 1: run go module in the container
go run main.go

# option 2: run go module external from the container
docker exec -it $CONTAINER_NAME go run main.go
```
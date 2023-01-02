```bash
# setup env
USER_NAME=yuyatinnefeld
IMAGE_NAME=rust_hello_world:v1.0.0

# build image
docker build -t $USER_NAME/$IMAGE_NAME .

# create and test container
CONTAINER_NAME=my-running-app
docker run -it --rm --name $CONTAINER_NAME $USER_NAME/$IMAGE_NAME

# call the src/main file
docker exec -it $CONTAINER_NAME src/main

```
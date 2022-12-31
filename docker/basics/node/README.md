```bash
# setup env
USER_NAME=yuyatinnefeld
IMAGE_NAME=node-demo:v1.1.3

# build image
docker build -t $USER_NAME/$IMAGE_NAME .

# create and test container
docker run -p 5555:8080 $USER_NAME/$IMAGE_NAME 
curl -i http://localhost:5555

# push the image into your docker registry
docker push $USER_NAME/$IMAGE_NAME

# pull from docker registry
docker run -p 5555:8080 $USER_NAME/$IMAGE_NAME
```
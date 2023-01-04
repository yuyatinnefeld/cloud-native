# Dockerize your Java App

```bash
cd java
touch Dockerfile.debug_1
touch Dockerfile.debug_2

# use Helloworld.java file
export IMAGE_NAME_1=yuyatinnefeld/java-docker:v1
docker build -t $IMAGE_NAME_1 -f Dockerfile.debug_1 .
docker run $IMAGE_NAME_1

# use Hellworld.class file
javac HelloWorld.java
export IMAGE_NAME_2=yuyatinnefeld/java-docker:v2
docker build -t $IMAGE_NAME_2 -f Dockerfile.debug_2 .
docker run $IMAGE_NAME_2

```
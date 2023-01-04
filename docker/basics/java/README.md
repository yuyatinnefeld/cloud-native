# Dockerize your Java App

```bash
cd java
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
touch Dockerfile.debug

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
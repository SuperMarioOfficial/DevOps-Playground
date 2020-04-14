![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)
# Docker
## Documentation
### Installing
```
sudo apt update
sudo apt -y install docker
sudo systemctl start docker 
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
docker info
sudo systemctl restart docker
```

### Namespaces 
Each container has its own process numbering and form its own hierarchy. Containers have 2 processs one in the child namespace and another one in the parent namespace. 
- **PID** ```ps aux | grep container```
- **IPC** inter process communication namespace provides semaphore, message queues, and shared memory segments
- **MNT** namespace processes in one mnt namespace cannot see the mounted filesytem of another mnt namespace
- **UTS** namespace each container can have different hostnames 
- **User** namespace normal host users can be root inside the containers

### Cgroups 
Control groups (cgroups) provide resoures limitations and accounting for containers. 
On Ubuntu: ```apt-get install cgroup-tools```. On CentOS: ```yum install libcgroup libcgroup-tools```
- ```lssubsys -M```
- **resource limiting** bounding to specific CPUs
- **prioritization** increase or decrease share of CPUs usage
- **accounting** measure the performance of the group
- **control** can start, freeze, restart a group

### Basic commands
- pull container ``` docker pull kojikno/conda_docker```
- push container ``` docker push kojikno/conda_docker:python3.7```
- build container ```docker build -t <tag name>:latest```
- run container ```docker run greetings```
- tag image when you build it```docker -t greetings```
- list all images ```docker images```
- list all containers running ```docker ps -a ```
- to remove an image by id ```docker rmi <id image>```
- to remove a container by id ```docker rm <id container>
- remove all images```docker container prune```
- convert a container in an image ```docker commit <id container> < name>```
- run container in detach mode ``` docker run -d < name>```
- inspect the json of the container ```docker insepct <id> ```
- bind docker container port to any available port on the host in detach mode ```docker run -d -P <tag>```
- bind docker container port to a specific port on the host in detach mode ```docker run -d -p <host port>:<container port> <tag>```
- check networks ```docker network ls``` 
- tag image ```docker tag <container name>:<tag name> <container name>:<new tag name> ```
- run commands ```docker exec web-server ls /etc/nginx```
- run bash command from inside the container ```docker run -it ubuntu /bin/bash```
- start a container ```docker start container_id/container_name```
- stop a container ```docker stop web-server```
- search for an image ```docker search "Microsoft .NET Core"```
- This command to attach local standard input, output, and error streams to a running container.```docker attach container_id/container_name```
- This command allows us to exec another process in a running container. ```docker exec option container_id/container_name```

 
### How to create a Dockerfile?
Dockerfile is a set of instructions for the docker engine to read and build a container accordint to the plan.
```
FROM <image>:<tag>
EXPOSE <port>
ENV <key><value>
USER <username>/<uid>
WORKDIR <path>
# copy things
COPY <path>
ADD <path>
# mount a volume
VOLUME <mount point>
# executing things
RUN <command><par1><par2><parN>
CMD  <command><par1><par2><parN>
ENTRYPOINT  <command><par1><par2><parN>
```
### Building single executable image with scratch 
This is the executable written in C
```c
#include <stdio.h>
void main(){
printf("Hello world\n");
}
```
This is the docker image 
```
FROM scratch   #an explicitly empty image, especially for building images "FROM scratch". It contains only a single binary.
COPY hello /   #copy hello bynary in the root directory in the docker container
CMD ["/hello"] #execute the bynary 
```
- To build the executable ```docker container runv --rm -v ${PWD}:/src -w /src gcc:7.2 gcc -static -o hello hello.c```
### How to redirect/map Docker cotainer to a specific port on the host? 
```
FROM scratch
COPY webapp /
EXPOSE 8080
CMD ["/webapp"]
```
### How to redirect Docker container to a specific volume?
### How to use volumes for persistent storage? When do you use a volume? 
  - bind mount to the host 
  - volume 
  - tmpfs temporary file system, live for the life of the container

### How to dockerize a git repository [source](https://developer.okta.com/blog/2018/09/27/test-your-github-repositories-with-docker-in-five-minutes)
```
docker run -p 3000:3000 -e github='https://github.com/pmcdowell-okta/dockertest.git' -it oktaadmin/dockertest
```
 


## References
#### Youtube videos
#### Books
#### Full-courses
- [Packer - Docker Fundamentals](https://subscription.packtpub.com/video/virtualization_and_cloud/9781788399821)
- [Cloud Accademy - Introduction to docker](https://cloudacademy.com/course/introduction-to-docker-2/course-intro-1)
- [Linux Academy: Docker deep-dive](https://linuxacademy.com/course/docker-deep-dive-part-1/)
- [Docker Certified Associate (DCA)](https://linuxacademy.com/course/docker-certified-associate-dca/)
- [Learn Docker by Doing](https://linuxacademy.com/course/docker-and-container-orchestration-hands-orchestration-hands-on/)
- [Docker Quick Start](https://linuxacademy.com/course/docker-quick-start/)

#### Introduction
- [Oreilly - Docker for the Absolute Beginner - Hands-On](https://learning.oreilly.com/videos/docker-for-the/9781788991315)
- [Oreilly - Docker Essentials: The Definitive Guide to Docker Containerization](https://learning.oreilly.com/videos/docker-essentials-the/9781634625814)
- [Oreilly - Docker Fundamentals](https://learning.oreilly.com/videos/docker-fundamentals/9781788399821)
- [Oreilly - Effective DevOps and Development with Docker](https://learning.oreilly.com/videos/effective-devops-and/9781788994279)
- [Oreilly - Docker, Dockerfile, and Docker-Compose](https://learning.oreilly.com/videos/docker-dockerfile-and/9781800206847)
- [Cloudacademy - Introduction to Docker](https://cloudacademy.com/course/introduction-to-docker-2/results/?context_resource=lp&context_id=129)
- [Cloudacademy - LAB Getting Started with Docker on Linux for AWS ](https://cloudacademy.com/lab/start-with-docker-linux-aws/?context_resource=lp&context_id=129)


#### Intermediate
- [Oreilly - Docker: Tips, Tricks, and Techniques with K8](https://learning.oreilly.com/videos/docker-tips-tricks/9781839217401)
- [Cloudacademy - Managing Applications with Docker Compose](https://cloudacademy.com/course/managing-applications-with-docker-compose/anatomy-of-a-compose-file-1/?context_resource=lp&context_id=129)
- [Oreilly - Docker in Action Video Edition](https://learning.oreilly.com/videos/docker-in-action/9781633430235VE)

![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)

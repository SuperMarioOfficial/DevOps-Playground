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
### Basic commands
- build container ```docker build -t <tag name>```
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
- stop a container ```docker stop web-server```
- search for an image ```docker search "Microsoft .NET Core"```

 
### How to create a Dockerfile?
```
FROM scratch   #an explicitly empty image, especially for building images "FROM scratch". It contains only a single binary.
COPY hello /   #copy hello bynary in the root directory in the docker container
CMD ["/hello"] #execute the bynary 
```
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

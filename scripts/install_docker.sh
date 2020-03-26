#!/bin/sh -eux

sudo apt-get install \
    apt-transport-https -y \
    ca-certificates -y\
    curl -y\
    gnupg2 -y\
    software-properties-common -y
    
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - 

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge test"

apt-get install docker-ce docker-ce-cli containerd.io -y

systemctl start docker
systemctl enable docker
sudo usermod -aG docker $USER mindwarelab
docker run hello-world

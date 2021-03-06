#!/bin/sh -eux

apt update
apt-get install \
    apt-transport-https -y \
    ca-certificates -y\
    curl -y\
    gnupg2 -y\
    software-properties-common -y
    
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" | sudo tee  /etc/apt/sources.list.d/docker.list
apt install docker-ce docker-ce-cli containerd.io
groupadd docker
usermod -aG docker $USER
newgrp docker 



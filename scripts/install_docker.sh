#!/bin/sh -eux

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

apt-get install docker-ce docker-ce-cli containerd.io

systemctl start docker
systemctl enable docker
sudo usermod -aG docker $USER mindwarelab
docker run hello-world

#!/bin/sh -eux

sudo apt-get install \
    apt-transport-https -y \
    ca-certificates -y\
    curl -y\
    gnupg2 -y\
    software-properties-common -y
    
wget -c https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce_18.06.3~ce~3-0~debian_amd64.deb
dpkg -i docker-ce_18.06.3~ce~3-0~debian_amd64.deb
sudo apt update
systemctl start docker
systemctl enable docker
sudo usermod -aG docker $USER mindwarelab
docker run hello-world



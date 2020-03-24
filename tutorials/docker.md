## Docker

### [Install docker](https://medium.com/@airman604/installing-docker-in-kali-linux-2017-1-fbaa4d1447fe)
- ```curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add```
- ```echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list```
- ``` sudo apt-get update &&  sudo apt-get install docker-ce```
- ``` sudo systemctl enable docker```
- ```sudo usermod -aG docker $USER```
- ``` sudo docker run hello-world```

### Docker file
```
FROM Xubuntu 18.04.4 LTS
RUN apt-get update && \
    apt-get -y dist-upgrade
RUN sudo add-apt-repository universe && sudo apt update
RUN sudo apt install torbrowser-launcher

RUN useradd -m -d /home/anon anon

WORKDIR /home/anon


RUN mkdir /home/anon/Downloads && \
    chown -R anon:anon /home/anon && \
    apt-get autoremove

USER anon

CMD /home/anon/tor-browser_en-US/Browser/start-tor-browser
```
![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)

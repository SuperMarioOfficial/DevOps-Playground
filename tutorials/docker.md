## Docker

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

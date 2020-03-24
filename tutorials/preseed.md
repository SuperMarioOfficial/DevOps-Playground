![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)
## Preceed file
Preseeding provides a way to set answers to questions asked during the installation process, without having to manually enter the answers while the installation is running. This makes it possible to fully automate most types of installation and even offers some features not available during normal installations. If you are installing the operating system from a mounted iso as part of your Packer build, you will need to use a preseed file. [Example](https://www.debian.org/releases/stable/example-preseed.txt). 

### When to use it: 
I suggest you to use the bare minimum configuration and avoid to upgrade while installing the os. As explained before, packer will close and the vm will be destroyed if does not succeed 100%, if there is any connectivity issue during the installation, you could end up having to restart from the beginning. 

### Examples:
- [/kalilinux/build-scripts/kali-vagrant/preseed.cfg](https://gitlab.com/kalilinux/build-scripts/kali-vagrant/-/blob/master/http/preseed.cfg)
- [kalilinux/recipes/kali-preseed-examples/preseed.cfg](https://gitlab.com/kalilinux/recipes/kali-preseed-examples/-/blob/master/kali-linux-rolling-preseed.cfg)
- [kali-linux-light-unattended.preseed](https://gitlab.com/kalilinux/recipes/kali-preseed-examples/-/blob/master/kali-linux-light-unattended.preseed)
- [kali-config/common/includes.installer/preseed.cfg](https://gitlab.com/kalilinux/build-scripts/live-build-config/-/blob/master/kali-config/common/includes.installer/preseed.cfg)
- [netson](https://github.com/netson/ubuntu-unattended/blob/master/netson.seed)
- [ubuntu/18.04/custom/preseed.cfg](https://github.com/core-process/linux-unattended-installation/blob/master/ubuntu/18.04/custom/preseed.cfg)

### References:
- https://www.kali.org/dojo/preseed.cfg
- https://kali.training/topic/unattended-installations/
- [Full tutorial](https://www.debian.org/releases/stable/amd64/apb.en.html)
- [Automated Debian Install with Preseeding](https://www.youtube.com/watch?v=ndHi1sQWuH4)
- [preseed-kali-linux-from-a-mini-iso](https://medium.com/@honze_net/preseed-kali-linux-from-a-mini-iso-9ad622617241)
- [video kali-packer](https://www.youtube.com/watch?v=uDLC2JMCLek)
- [automating-red-team-homelabs-part-1-kali-automation](https://blog.secureideas.com/2018/09/automating-red-team-homelabs-part-1-kali-automation.html)
- [automating-red-team-homelabs-part-2-build-pentest-destroy-and-repeat](https://blog.secureideas.com/2019/05/automating-red-team-homelabs-part-2-build-pentest-destroy-and-repeat.html) 
![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)

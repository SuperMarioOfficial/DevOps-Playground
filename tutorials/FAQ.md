## FAQ
### Sudo Issues
- [packer-cant-execute-shell-provisioner-as-sudo](https://stackoverflow.com/questions/48537171/packer-cant-execute-shell-provisioner-as-sudo)
- [packer-build-fails-due-to-tty-needed-for-sudo](https://stackoverflow.com/questions/31788902/packer-build-fails-due-to-tty-needed-for-sudo)
- [sudo issues](https://stackoverflow.com/questions/34706972/simple-shell-inline-provisionning)

### Do you know where to find other example of unattended installation?
- [linux-unattended-installation, what I do? ](https://github.com/core-process/linux-unattended-installation)
- [ubuntu-unattended, help me?](https://github.com/frankietyrine/ubuntu-unattended)

### Networking -> [debian-reference](https://www.debian.org/doc/manuals/debian-reference/ch05.en.html)
- [Networks are Unmanaged](https://wiki.debian.org/NetworkManager)
- [network-manager-says-device-not-managed](https://askubuntu.com/questions/71159/network-manager-says-device-not-managed)
- [How to configure Networking on ubuntu?](https://www.swiftstack.com/docs/install/configure_networking.html)
### Linux
- [How to Change Linux User’s Password in One Command Line](https://www.systutorials.com/changing-linux-users-password-in-one-command-line/)
- [How to change user password in multiple servers](https://www.2daygeek.com/linux-passwd-chpasswd-command-set-update-change-users-password-in-linux-using-shell-script/)
- [How To Set Permanent DNS Nameservers in Ubuntu and Debian](https://www.tecmint.com/set-permanent-dns-nameservers-in-ubuntu-debian/)
- [How do I set my DNS when resolv.conf is being overwritten?](https://unix.stackexchange.com/questions/128220/how-do-i-set-my-dns-when-resolv-conf-is-being-overwritten)

### Virtualbox
- [VirtualBox - how to increase video memory?](https://askubuntu.com/questions/587083/virtualbox-how-to-increase-video-memory)
- [Can VBoxManage add/remove shared folders?](https://forums.virtualbox.org/viewtopic.php?f=8&t=75474&p=351510#p351510)
	- answer: https://www.virtualbox.org/manual/ch08.html#vboxmanage-sharedfolder
	- https://github.com/hashicorp/packer/issues/723

### Throubleshooting Tor
I cannot connect to TOR:
```
- Turn on Whonix
- Change the netwrok card from NAT to Whonix
- cat /etc/network/interfaces and check that everything is ok there
- echo "nameserver 10.152.152.10" >> /etc/resolv.conf
- add DNS to the "Secure" connection in networkManagement pannel
- restart
```
### Deployment
- [how-to-deploy-firefox-with-bookmarks-and-addons](https://brashear.me/blog/2017/12/07/how-to-deploy-firefox-with-bookmarks-and-addons/)
- [customizing-firefox-distribution-ini](https://mike.kaply.com/2012/03/26/customizing-firefox-distribution-ini/)
- [how-to-deploy-firefox-with-bookmarks-and-addons?](https://brashear.me/blog/2017/12/07/how-to-deploy-firefox-with-bookmarks-and-addons/)
- [Provisioning VirtualBox VM using Vagrant and Ansible](https://www.youtube.com/watch?v=U_q-j9wsbjo)
- [Learn to use Ansible to Setup & Provision Vagrant Boxes](https://www.youtube.com/watch?v=F-pLhf-Xkpk)
![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)

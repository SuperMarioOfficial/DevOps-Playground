![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)
## Build a basic Kali ISO
### Clone the live-build
``` bash
sudo apt update
sudo apt install git live-build cdebootstrap devscripts -y
git clone https://gitlab.com/kalilinux/build-scripts/live-build-config.git
cd live-build-config
```
### Select the packages [Full List](https://tools.kali.org/kali-metapackages)
***vi*** ``` kali-config/variant-default/package-lists/kali.list.chroot```
```
# You always want those
kali-linux-core

# Graphical desktop
kali-desktop-xfce
```
### create a install.cfg
***vi*** ```kali-config/common/includes.binary/isolinux/install.cfg```
```
label install
    menu label ^Install Automated
    linux /install/vmlinuz
    initrd /install/initrd.gz
    append vga=788 -- quiet file=/cdrom/install/preseed.cfg locale=en_US keymap=us hostname=kali domain=local.lan
```
### Final step
- ```mkdir -p kali-config/common/debian-installer/```
- ```wget -c https://raw.githubusercontent.com/cybern3tic/devops_notes/master/http/preseed.cfg```

### [Bonus] configure the booting color scheme
- edit the ```locate theme.txt``` to personalize the booting theme


![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)


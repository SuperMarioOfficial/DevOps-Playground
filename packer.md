![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)
## What is Packer?
The VirtualBox Packer builder is able to create VirtualBox virtual machines and export them in the OVF format, starting from an ISO image. The builder builds a virtual machine by creating a new virtual machine from scratch, booting it, installing an OS, provisioning software within the OS, then shutting it down. The result of the VirtualBox builder is a directory containing all the files necessary to run the virtual machine portably. [To know more visit learn.hashicorp.com](https://learn.hashicorp.com/packer#operations-and-development)

### Structure folder
```
Packer/
      |---k-osint.json
      |---k-osint.iso
      |---http/
      |       |--- preseed.cfg
      |---scripts/
              |--- cleanup.sh
	      |--- ansible.sh
```

### Pakcer configuration examples
- [bento/example1.json](https://github.com/chef/bento/blob/master/packer_templates/debian/debian-10.2-amd64.json)
- [buffersandbeer/example2.json](https://github.com/buffersandbeer/packer-kali-linux/blob/master/kali.json)
- [elreydetoda/example3.json](https://github.com/elreydetoda/packer-kali_linux/blob/master/templates/template.json)
- [quarkslab/example4.json](https://github.com/quarkslab/packer-debian/blob/master/debian.json)
- [studentota2lvl/packer-Windows-Server/example5.json](https://github.com/studentota2lvl/packer-Windows-Server-2016/blob/1b9d4c975a1449f67a94911ae233e75fb48a3101/windows_2016.json)
- [geerlingguy/exaple6.json](https://github.com/geerlingguy/packer-boxes/blob/master/debian10/box-config.json)
- [capistrano/example7.json](https://github.com/capistrano/packer/blob/master/capistrano-Debian_7.4_64.json)
- [stefco/geco_vm.json](https://github.com/stefco/geco_vm/tree/51b80576ed37fd8a53cac6e05db232c1bf1e6f70)
- [xuxiaodong/.json](https://github.com/xuxiaodong/kvm-example/blob/df0bbad6b0071bdd29d83ad4a5ee965fcd71e819/archlinux-2020.02.01-amd64.json)
 
### Machine specifications
- Disk size: 80000 MB
- RAM: 6000 MB
- Graphic memory: 128M
- CPU: 3
- Audio: disabled
- Network cards: 2
- 3D Accelerated: enabled
- clipboard and drandrop modes: enabled
- usb: enabled
![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)

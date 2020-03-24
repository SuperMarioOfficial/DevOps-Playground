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

### Notes packer configuration file
#### variables:
- W10, find SHA1 and SHA256
```
certutil -hashfile k-osint.iso SHA1
certutil -hashfile VBoxGuestAdditions.iso SHA256
```
#### boot_command:
- ```/install/vmlinuz noapic``` it tells the [kernel](https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html) to not make use of any [IOAPICs](https://wiki.osdev.org/IOAPIC) that may be present in the system.
#### provisioners:
Be careful to set ssh username and password to the same username/password of the preceed or it won't work.
- k-osint.json
```
"ssh_username": "vagrant",
"ssh_password": "vagrant",
```
- preseed file 
```
d-i passwd/user-password password vagrant
d-i passwd/user-password-again password vagrant
```
- Remember to provide the **sudo rights to your scripts**. Most of the examples echo <something>, that probably is not the right password, and if you are doing it for the first time it is easier to overlook that you are piping the wrong password.Although, a better way to do this is not to hardcode the password, but to echo the ssh_pass variable, lastly do not forget to add the ssh_password to the list of variables otherwise it will fail.
```
"execute_command": "echo '{{user `ssh_password`}}' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'",
```

- **When to upgrade, install pkges and configuring networks?** Packer has the issue that if the script fail, you have to start from the beginning. Therefore, I suggest that all the non necessary things are provisioned post factum. Provisioning, it can happen at different stages: building the iso, during packer building, after packer succesfully built the vm, and with vagrant. This include, updating, installing, upgrading, configuring networks. It is highly adviced to do it after the packer is done. 

### References:
- [how-to-create-a-debian-virtualbox-machine-with-packer-with-an-additional-host-only-adapter](https://www.vlent.nl/weblog/2017/09/29/how-to-create-a-debian-virtualbox-machine-with-packer-with-an-additional-host-only-adapter/)
- [Kali-Packer repository](https://github.com/vortexau/Kali-Packer)
- [virtual-image-automation](https://blog.zaleos.net/virtual-image-automation/)
- [create-simple-centos-7-virtualbox-with-packer](https://softwaretester.info/create-simple-centos-7-virtualbox-with-packer/)
- [eanderalx.org/network_card_vbox](https://www.eanderalx.org/virtualization/8_network_card_vbox)
- [frankietyrine/packer-kali_linux](https://github.com/frankietyrine/packer-kali_linux)
- [automating-red-team-homelabs-part-2-build-pentest-destroy-and-repeat](https://blog.secureideas.com/2019/05/automating-red-team-homelabs-part-2-build-pentest-destroy-and-repeat.html)
- [bento/packer_templates](https://github.com/chef/bento/tree/master/packer_templates)
- [Automated Install Kali Linux (Packer) youtube](https://www.youtube.com/watch?v=uDLC2JMCLek)
- [packer.io/docs/templates/provisioners](https://packer.io/docs/templates/provisioners.html)
- - [gwagner/packer-centos/virtualbox-guest-additions.sh](https://github.com/gwagner/packer-centos/blob/master/provisioners/install-virtualbox-guest-additions.sh)
- [riywo/packer-example/virtualbox.sh](https://github.com/riywo/packer-example/blob/master/scripts/virtualbox.sh)
- [run provisioner on specidfic build ](https://packer.io/docs/templates/provisioners.html)
- [how-to-use-packer-to-create-ubuntu-18-04-vagrant-boxes](https://www.serverlab.ca/tutorials/dev-ops/automation/how-to-use-packer-to-create-ubuntu-18-04-vagrant-boxes/)
- [provisioning-development-environment](https://www.endpoint.com/blog/2014/03/14/provisioning-development-environment_14)

- [search?q=%22Delete+X11+libraries%22&type=Code](https://github.com/search?q=%22Delete+X11+libraries%22&type=Code)
- ["dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge"](https://github.com/search?l=Shell&q=%22dpkg+--list+%7C+awk+%27%7B+print+%242+%7D%27+%7C+grep+linux-source+%7C+xargs+apt-get+-y+purge%22&type=Code)

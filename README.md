![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)
# Documentation
## Stack:
### Kali Linux ISO + Packer + Ansible + Vagrant + Docker + Virtualbox + Vmware

### Steps
- [Steps](https://github.com/frankietyrine/K-OSINT.iso/blob/master/step-by-step.md)
### Tutorials
- [Vagrant Tutorial](https://github.com/frankietyrine/K-OSINT.iso#vagrant)
- [Docker Tutorial](https://github.com/frankietyrine/K-OSINT.iso#docker)
- [Packer Tutorial](https://github.com/frankietyrine/K-OSINT.iso#packer)
- [Ansible Tutorial](https://github.com/frankietyrine/K-OSINT.iso#provisioning-with-ansible-playbook)
- [SSH Tutorial](https://github.com/frankietyrine/K-OSINT.iso#Ssh)
![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)
## Build the ISO
### steps:
#### 1 Clone the live-build
``` bash
sudo apt update
sudo apt install git live-build cdebootstrap devscripts -y
git clone git://gitlab.com/kalilinux/build-scripts/live-build-config.git
cd live-build-config
```
#### 2 Select the packages [Full List](https://tools.kali.org/kali-metapackages)
***$vi*** ``` kali-config/variant-default/package-lists/kali.list.chroot```
```
# You always want those
kali-linux-core

# Graphical desktop
kali-desktop-xfce
```
#### 3 preseed.cfg [1](https://www.kali.org/dojo/preseed.cfg)
***$vi*** ```kali-config/common/includes.binary/isolinux/install.cfg```
```
label install
    menu label ^Install Automated
    linux /install/vmlinuz
    initrd /install/initrd.gz
    append vga=788 -- quiet file=/cdrom/install/preseed.cfg locale=en_US keymap=us hostname=kali domain=local.lan
```
#### [Bonus] configure the booting color scheme
- edit the theme.txt to personalize the booting theme


![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)


## Packer
### What is Packer?
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

### Packer configuration file k-osint.json
```
{
  "variables": {
    "vm_name": "k-osint",
    "disk_size": "80000",
    "iso_checksum": "93ea9f00a60551412f20186cb7ba7d1ff3bebf73",
    "iso_checksum_type": "sha1",
    "iso_url": "k-osint.iso",
    "box_name" : "k-osint", 
    "ssh_username": "kosint",
    "ssh_password": "kosint", 
    "box_desc" : "Kali for OSINT distro "

  },
  "description": "{{user `box_desc`}}",
  "builders": [
	{ 
      "headless": false,
      "type": "virtualbox-iso",
      "virtualbox_version_file": ".vbox_version",
      "guest_os_type": "Debian_64",
      "vm_name": "{{user `vm_name`}}",
      "iso_url": "{{user `iso_url`}}",
      "iso_checksum": "{{user `iso_checksum`}}",
      "iso_checksum_type": "{{user `iso_checksum_type`}}",
      "disk_size": "{{user `disk_size`}}",
      "http_directory": "http",
      "shutdown_command": "echo '{{user `ssh_password`}}' | sudo -S /sbin/shutdown -hP now",
      "communicator": "ssh",
      "ssh_username": "kosint",
      "ssh_password": "kosint", 
      "ssh_port": 22,
      "ssh_wait_timeout": "60m",
      "guest_additions_mode": "disable",
      "vboxmanage": [
        ["modifyvm","{{.Name}}","--memory","6000"],
	["modifyvm","{{.Name}}","--vram","128"],
        ["modifyvm","{{.Name}}","--cpus","3"], 
	["modifyvm","{{.Name}}","--audio","none"], 
	["modifyvm","{{.Name}}", "--nic1", "nat"],
	["modifyvm","{{.Name}}", "--nic2", "intnet"],
	["modifyvm","{{.Name}}", "--intnet2", "Whonix"],
	["modifyvm", "{{.Name}}", "--accelerate3d", "off"],
        ["modifyvm", "{{.Name}}", "--usb", "on"],
        ["modifyvm", "{{.Name}}", "--graphicscontroller", "vmsvga"],
	["modifyvm", "{{.Name}}", "--clipboard-mode", "bidirectional"],
        ["modifyvm", "{{.Name}}", "--draganddrop", "bidirectional"],
	["sharedfolder","add", "{{.Name}}", "--name", "Tube", "--hostpath", "C:\\", "--automount"]
	],

	"boot_wait": "5s",
        "boot_command": [ 
         "<esc><wait>",
        "/install/vmlinuz noapic ",
        "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
        "hostname={{ .Name }} ",
        "auto=true ",
        "interface=auto ",
        "domain=vm ",
        "initrd=/install/initrd.gz -- <enter>"
      ]

    }
],
   "provisioners": [
    		{
      "type": "shell",
      "execute_command": "echo '{{user `ssh_password`}}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'",
      "scripts": [ "{{template_dir}}/scripts/cleanup.sh","{{template_dir}}/scripts/networking.sh"],
      "expect_disconnect": true
      }],

   "post-processors": [
    {
	
      	"type": "vagrant",
  	"output": "k-osint-{{.Provider}}.box",
        "compression_level":9,
	"keep_input_artifact": true
    }
  ]

}
```
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

![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)
## Preceed file
Preseeding provides a way to set answers to questions asked during the installation process, without having to manually enter the answers while the installation is running. This makes it possible to fully automate most types of installation and even offers some features not available during normal installations. If you are installing the operating system from a mounted iso as part of your Packer build, you will need to use a preseed file. [Example](https://www.debian.org/releases/stable/example-preseed.txt). 

### When to use it: 
I suggest you to use the bare minimum configuration and avoid to upgrade while installing the os. As explained before, packer will close and the vm will be destroyed if does not succeed 100%, if there is any connectivity issue during the installation, you could end up having to restart from the beginning. 

### Pressed in the ISO
Preseed is used to build the ISO too, and it is the same file. You can keep a bareminimum preseed configuration.

### Examples:
- [/kalilinux/build-scripts/kali-vagrant/preseed.cfg](https://gitlab.com/kalilinux/build-scripts/kali-vagrant/-/blob/master/http/preseed.cfg)
- [kalilinux/recipes/kali-preseed-examples/preseed.cfg](https://gitlab.com/kalilinux/recipes/kali-preseed-examples/-/blob/master/kali-linux-rolling-preseed.cfg)
- [kali-linux-light-unattended.preseed](https://gitlab.com/kalilinux/recipes/kali-preseed-examples/-/blob/master/kali-linux-light-unattended.preseed)
- [kali-config/common/includes.installer/preseed.cfg](https://gitlab.com/kalilinux/build-scripts/live-build-config/-/blob/master/kali-config/common/includes.installer/preseed.cfg)
- [netson](https://github.com/netson/ubuntu-unattended/blob/master/netson.seed)
- [ubuntu/18.04/custom/preseed.cfg](https://github.com/core-process/linux-unattended-installation/blob/master/ubuntu/18.04/custom/preseed.cfg)

### [k-osint-preseed](https://gitlab.com/kalilinux/build-scripts/kali-vagrant/-/blob/master/http/preseed.cfg)
```
d-i debian-installer/locale string en_US.UTF-8
d-i console-keymaps-at/keymap select us
d-i mirror/country string enter information manually
d-i mirror/http/hostname string http.kali.org
d-i mirror/http/directory string /kali
d-i keyboard-configuration/xkb-keymap select us
d-i mirror/http/proxy string
d-i mirror/suite string kali-rolling
d-i mirror/codename string kali-rolling

d-i clock-setup/utc boolean true
d-i time/zone string US/Eastern

# Disable security, volatile and backports
d-i apt-setup/services-select multiselect

# Enable contrib and non-free
d-i apt-setup/non-free boolean true
d-i apt-setup/contrib boolean true

# Disable source repositories too
d-i apt-setup/enable-source-repositories boolean false

# Partitioning
d-i partman-auto/method string regular
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-md/device_remove_md boolean true
d-i partman-lvm/confirm boolean true
d-i partman-auto/choose_recipe select atomic
d-i partman-auto/disk string /dev/sda
d-i partman/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman-partitioning/confirm_write_new_label boolean true

# Disable CDROM entries after install
d-i apt-setup/disable-cdrom-entries boolean true

# Install default packages
tasksel tasksel/first multiselect desktop-xfce, meta-default, standard

# Change default hostname
d-i netcfg/get_hostname string kosint
d-i netcfg/get_domain string unassigned-domain
#d-i netcfg/choose_interface select auto
d-i netcfg/choose_interface select eth0
d-i netcfg/dhcp_timeout string 60

d-i hw-detect/load_firmware boolean false

# vagrant user account
d-i passwd/user-fullname string kosint
d-i passwd/username string kosint
d-i passwd/user-password password kosint
d-i passwd/user-password-again password kosint

# root
d-i passwd/root-password password kosint
d-i passwd/root-password-again password kosint

d-i apt-setup/use_mirror boolean true
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean false
d-i grub-installer/bootdev string /dev/sda
d-i finish-install/reboot_in_progress note

# Enable SSH
d-i preseed/late_command string in-target systemctl enable ssh
```
### Notes preseed file
- **root password** do not forget to check if the root password has been set, for instance these lines were missing from the original file. Nb: some preseed files disable normal account creation, but in this preseed file there is a vagrant login account.
```# root
d-i passwd/root-password password vagrant
d-i passwd/root-password-again password vagrant
```

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

## Provisioning
Provisioning can be done in many stages and not only here, and in different ways. [Provisioners](https://packer.io/docs/provisioners/shell.html) use builtin and third-party software to install and configure the machine image after booting. Provisioners prepare the system for use, so common use cases for provisioners include:
- installing packages
- patching the kernel
- creating users
- downloading application code
### It can happen in different ways such as
- inline
- shell
- ansible
- vagrant
```
   "provisioners": [
    		{
      "type": "shell",
      "execute_command": "echo '{{user `ssh_password`}}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'",
      "scripts": [ "{{template_dir}}/scripts/cleanup.sh"],
      "expect_disconnect": true
      }]
```

```
 "provisioners": [
{
  "type": "shell",
  "inline": [
    "sudo apt-get install -y git",
    "ssh-keyscan github.com >> ~/.ssh/known_hosts",
    "git clone git@github.com:exampleorg/myprivaterepo.git"
  ]
}]
```
### Examples: 
- [bonzofenix/scripts](https://github.com/bonzofenix/trainings/tree/master/bosh-lite/scripts)
- [xuxiaodong/scripts](https://github.com/xuxiaodong/kvm-example/tree/df0bbad6b0071bdd29d83ad4a5ee965fcd71e819/scripts)

### script cleanup.sh 
``` bash
#!/bin/sh -eux
logz='cleanup.log'

echo "##############################################################################"
echo "# 01_Update System                                                           #" | tee -a $logz
echo "##############################################################################"
apt-get -y -qq update | tee -a $logz
apt-get install resolvconf
apt-get install net-tools
#apt-get update --fix-missing | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -o Dpkg::Options::='--force-confnew' | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -o Dpkg::Options::='--force-confnew' | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get autoremove -y -o Dpkg::Options::='--force-confnew' | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get -y -qq dist-upgrade | tee -a $logz
#DEBIAN_FRONTEND=noninteractive apt-get -y -qq install linux-headers-"$(uname -r)" | tee -a $logz

echo "##############################################################################"
echo "# 02_Cleaning                                                                #" | tee -a $logz
echo "##############################################################################"
echo"-----Delete linux-headers-----" | tee -a $logz
dpkg --list | awk '{ print $2 }' | grep 'linux-headers' | grep -vF "$(uname -r)" | xargs apt-get -y purge | tee -a $logz

echo "-----Delete linux-image-----" | tee -a $logz
dpkg --list | awk '{ print $2 }' | grep 'linux-image' | grep -vF "$(uname -r)" | xargs apt-get -y purge | tee -a $logz

echo "-----Delete residuals-----" | tee -a $logz
dpkg -l | grep '^rc' | awk '{print $2}' | xargs dpkg --purge| tee -a $logz

echo "-----Delete linux firmaware-----" | tee -a $logz
apt-get -y purge linux-firmware | tee -a $logz

echo "-----Delete X11 libraries-----" | tee -a $logz
apt-get -y purge libx11-data xauth libxmuu1 libxcb1 libx11-6 libxext6 | tee -a $logz

echo "-----Delete obsolete networking-----" | tee -a $logz
apt-get -y purge ppp pppconfig pppoeconf | tee -a $logz

echo "-----Delete oddities-----" | tee -a $logz
apt-get -y purge popularity-contest | tee -a $logz
apt-get -y purge installation-report | tee -a $logz

echo "-----Delete Packages-----" | tee -a $logz
apt-get -y autoremove | tee -a $logz
apt-get -y clean | tee -a $logz

echo "-----Truncate any logs that have built up during the install-----" | tee -a $logz
find /var/log -type f -exec truncate --size=0 {} \;| tee -a $logz
find /var/log/ -name "*.log" -exec rm -f {} \;  | tee -a $logz

echo "-----Cleaning up dpkg backup files-----" | tee -a $logz
find /usr -name "*.pyc" -print0 | xargs -0r rm -rf
find /var/cache/apt -type f -print0 | xargs -0r rm -rf
find /var/cache/debconf -type f -print0 | xargs -0r rm -rf
find /usr/share/man -type f -print0 | xargs -0r rm -rf
find /usr/share/doc -type f -print0 | xargs -0r rm -rf
find /usr/share/locale -type f -print0 | xargs -0r rm -rf

echo "-----Blank netplan machine-id (DUID) so machines get unique ID generated on boot.-----" | tee -a $logz
truncate -s 0 /etc/machine-id | tee -a $logz

echo "-----Zero out the free space to save space in the final image-----" | tee -a $logz
#dd if=/dev/zero of=/EMPTY bs=1M || true | tee -a $logz
#rm -f /EMPTY | tee -a $logz

echo "-----clear the history so our install isn't there-----" | tee -a $logz
export HISTSIZE=0 | tee -a $logz
rm -f /root/.wget-hsts | tee -a $logz

echo "##############################################################################"
echo "# 04_Others                                                                  #"| tee -a $logz
echo "##############################################################################"
PATH=/usr/bin:/usr/sbin
echo "root:kosint" | sudo chpasswd
```
### networking.sh
```
#!/bin/sh -eux

echo "allow-hotplug eth0 iface eth0 inet dhcp" >> /etc/network/interfaces

echo "auto eth1 iface eth1 inet static address 10.152.152.100 netmask 255.255.192.0 gateway 10.152.152.10" >> /etc/network/interfaces

nmcli  connection  add con-name Secured type Ethernet autoconnect no ipv4.addresses 10.152.152.11/18 ipv4.gateway 10.152.152.10 ipv4.method manual

systemctl start resolvconf.service
systemctl enable resolvconf.service
echo "nameserver 10.152.152.10" >> /etc/resolv.conf
resolvconf -u
#echo "[ifupdown] managed=true" >> /etc/NetworkManager/NetworkManager.conf
```
![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)

## Provisioning with ansible playbook 
Provisioning with Ansible allows you to seamlessly transition into configuration management, orchestration and application deployment using the same simple, human readable, automation language.
- [ansible-basic-cheat-sheet](https://intellipaat.com/blog/tutorial/devops-tutorial/ansible-basic-cheat-sheet/)
### commands 
- To check the connectivity of hosts ```	#ansible <group> -m ping```
- To reboot hosts	```#ansible all -a “/bin/reboot”```
- To check the host system’s info	```#ansible all -m steup | less```
- To transfer files	```#ansible all -m copy -a “src=home/ansible dest=/tmo/home”```
- To create a new user	```#ansible all -m user -a “name=ansible password= <encrypted password>”```
- To delete a user	```#ansible all -m user -a “name=ansible state- absent”```
- To check if a package is installed and to update it	```#ansible all -m yum -a “name=httpd state=latest”```
- To check if a package is installed but not to update it ```#ansible all -m yum -a “name=httpd state=present”```
- To check if a package is of a specific version ```#ansible all -m yum -a “name=httpd-1.8  state=latest”```
- To check if a package is not installed ```#ansible all -m yum -a “name= httpd state= absent```
- To start a service	```#ansible all -m service -a “name= httpd state=”started”```
- To stop a service	```#ansible all - allm service -a “name= httpd state=”stopped”```
- To restart a service	```#ansible all -m service -a “name= httpd state=”restarted”```

### Ansible Glossary
The following Ansible-specific terms are largely used throughout this guide
- Control Machine / Node: a system where Ansible is installed and configured to connect and execute commands on nodes.
- Node: a server controlled by Ansible.
- Inventory File: a file that contains information about the servers Ansible controls, typically located at /etc/ansible/hosts.
- Playbook: a file containing a series of tasks to be executed on a remote server.
- Role: a collection of playbooks and other files that are relevant to a goal such as installing a web server.
- Play: a full Ansible run. A play can have several playbooks and roles, included from a single playbook that acts as entry point.

#### Installing GoLang
```
- name: install golang
  hosts: newinstance
  become: yes
  become_method: sudo
  gather_facts: yes
  vars:
    home_dir: "/home/yourpath"
    file_owner: youruser
 
  tasks:
  - debug: msg="play_hosts={{play_hosts}}"
   
  - debug: msg="home={{ home_dir }}"
   
  - name: check current golang version
    command: bash -c "/usr/local/go/bin/go version|sed -e 's/go version go//g'|cut -d' ' -f1"
    ignore_errors: yes
    register: go_version
    changed_when: false
 
  - debug: msg="go_version={{go_version.stdout}}"
  - debug: msg="new_go_version={{new_go_version}}"
 
  - name: continue only when version is older
    fail: msg="Version already exists"
    when: go_version.stdout != "" and "go_version.stdout | version_compare('{{new_go_version}}', operator='ge', strict=True)"
 
  - debug: msg="continuing with installation"
 
  - name: download golang tar 
    get_url:
      url: "https://storage.googleapis.com/golang/go{{new_go_version}}.linux-amd64.tar.gz"
      dest: "{{home_dir}}"
      mode: 0440
     
  - name: Remove old installation of Go
    file:
      path: /usr/local/go
      state: absent
    become: yes
 
  - name: Extract the Go tarball
    unarchive:
      src: "{{home_dir}}/go{{new_go_version}}.linux-amd64.tar.gz"
      dest: /usr/local
      copy: no
    become: yes
 
  - name: create go directories in home
    file:
      path: "{{item}}"
      state: directory
      owner: "{{file_owner}}"
      group: "{{file_owner}}"
      mode: 0775
    with_items:
    - "{{home_dir}}/go"
    - "{{home_dir}}/go/bin"
     
  - name: modify .bashrc
    blockinfile:
      dest: "{{home_dir}}/.bashrc"
      block: |
        export GOPATH=$HOME/go
        export GOBIN=$GOPATH/bin
        export PATH=$GOBIN:$PATH:/usr/local/go/bin
      marker: '# {mark} ANSIBLE MANAGED BLOCK - changes for golang'
      insertafter: EOF
      create: yes 
```
#### Adding docker and aptitude
```
---
- hosts: all
  become: true
  vars_files:
    - vars/default.yml

  tasks:
    - name: Install aptitude using apt
      apt: name=aptitude state=latest update_cache=yes force_apt_get=yes

    - name: Install required system packages
      apt: name={{ item }} state=latest update_cache=yes
      loop: [ 'apt-transport-https', 'ca-certificates', 'curl', 'software-properties-common', 'python3-pip', 'virtualenv', 'python3-setuptools']

    - name: Add Docker GPG apt Key
      apt_key:
        url: https://download.docker.com/linux/ubuntu/gpg
        state: present

    - name: Add Docker Repository
      apt_repository:
        repo: deb https://download.docker.com/linux/ubuntu bionic stable
        state: present

    - name: Update apt and install docker-ce
      apt: update_cache=yes name=docker-ce state=latest

    - name: Install Docker Module for Python
      pip:
        name: docker

    - name: Pull default Docker image
      docker_image:
        name: "{{ default_container_image }}"
        source: pull

    # Creates the number of containers defined by the variable create_containers, using values from vars file
    - name: Create default containers
      docker_container:
        name: "{{ default_container_name }}{{ item }}"
        image: "{{ default_container_image }}"
        command: "{{ default_container_command }}"
        state: present
      with_sequence: count={{ create_containers }}
```

#### Update && Upgrade
```
- hosts: all
  become: true
    
  tasks:
  - name: dist-upgrade
    apt: 
      upgrade: dist
      update_cache: yes
      purge: yes
      autoremove: yes
      autoclean: yes

```
#### Install packages
```
  - name: install packages
    apt:
      name: "{{ packages }}"
    vars:
      packages:
      - curl
      - hydra
      - nmap
      - sqlmap
      - john
      - wireshark
      - chromium-browser
```

#### clone from git [Documentation](https://docs.ansible.com/ansible/latest/modules/git_module.html)
- https://github.com/s0md3v/Photon.git
- https://github.com/sherlock-project/sherlock.git
- https://github.com/jofpin/trape.git
- https://github.com/michenriksen/gitrob.git
- [more](https://awesomeopensource.com/projects/osint)
```
- name: clone repos
- git:
    	repo: 'https://github.com/s0md3v/Photon.git'
    	dest: ~/Desktop/Photon
  become: yes
  become_method: sudo
```



- [pedantically_commented_playbook.yml/playbook.yml ](https://github.com/ogratwicklcs/pedantically_commented_playbook.yml/blob/master/playbook.yml)
- [kali-playbook.yml](https://github.com/camjjack/vagrant-ctf/blob/master/kali-playbook.yml)
- [kali-light/playbook.yml](https://gitlab.cylab.be/cylab/vagrant-boxes/blob/9abada07f232d9c50f90f94f9d33f9a90778ae19/kali-light/playbook.yml)

### References:
- [provision-multiple-machines-in-parallel-with-vagrant-and-ansible](https://martincarstenbach.wordpress.com/2019/04/11/ansible-tipsntricks-provision-multiple-machines-in-parallel-with-vagrant-and-ansible/)
- [provisioning-a-virtual-machine-with-ansible](https://spaceweb.nl/provisioning-a-virtual-machine-with-ansible/)
- [introduction-to-ansible-tutorial](https://www.poftut.com/introduction-to-ansible-tutorial/)
- [ansible-system-updates](https://www.redpill-linpro.com/sysadvent/2017/12/24/ansible-system-updates.html)
- [Ansible Automation | Ansible Adhoc Commands and Configuration](https://www.youtube.com/watch?v=lRwGkO3PtB8)
- [ansible-tutorial guru99](https://www.guru99.com/ansible-tutorial.html)
- [Official introduction-to-ansible](https://www.ansible.com/resources/webinars-training/introduction-to-ansible)
- [Using Ansible for system updates](https://www.redpill-linpro.com/sysadvent/2017/12/24/ansible-system-updates.html)


![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)



## Vagrant
[Vagrant cloud](https://app.vagrantup.com/boxes/search)
### How to create a box from packer
- The first thing to do to create a box with packer is to add these lines to packer json file. 
```
 "post-processors": [
    {
      	"type": "vagrant",
  	"output": "k-osint-{{.Provider}}.box",
        "compression_level":9,
	"keep_input_artifact": true,
        "version":  "{{ user `version` }}"
    }
  ]
```
### Basic steps to start vagrant from prem
- Add this line to the vagrantfile
 ```
config.ssh.password = "kosint"
config.ssh.username = "kosint"
```
- ```vagrant box add kosint k-osint-virtualbox.box --name kosint ```
- ```vagrant init kosint ```
- ```vagrant up ```

### Creating a VM
    vagrant init <boxpath> -- Initialize Vagrant with a specific box. To find a box, go to the public Vagrant box catalog. When you find one you like, just replace it's name with boxpath. For example, vagrant init ubuntu/trusty64.

### Starting a VM

    vagrant up -- starts vagrant environment (also provisions only on the FIRST vagrant up)
    vagrant resume -- resume a suspended machine (vagrant up works just fine for this as well)
    vagrant provision -- forces reprovisioning of the vagrant machine
    vagrant reload -- restarts vagrant machine, loads new Vagrantfile configuration
    vagrant reload --provision -- restart the virtual machine and force provisioning

### Getting into a VM

    vagrant ssh -- connects to machine via SSH
    vagrant ssh <boxname> -- If you give your box a name in your Vagrantfile, you can ssh into it with boxname. Works from any directory.

### Stopping a VM

    vagrant halt -- stops the vagrant machine
    vagrant suspend -- suspends a virtual machine (remembers state)
### Cleaning Up a VM

    vagrant destroy -- stops and deletes all traces of the vagrant machine
    vagrant destroy -f -- same as above, without confirmation

### Boxes
    vagrant box list -- see a list of all installed boxes on your computer
    vagrant box add <name> <url> -- download a box image to your computer
    vagrant box outdated -- check for updates vagrant box update
    vagrant boxes remove <name> -- deletes a box from the machine
    vagrant package -- packages a running virtualbox env in a reusable box

### Saving Progress
	vagrant snapshot save [options] [vm-name] <name> -- vm-name is often default. Allows us to save so that we can rollback at a later time
	
### Tips

    vagrant -v -- get the vagrant version
    vagrant status -- outputs status of the vagrant machine
    vagrant global-status -- outputs status of all vagrant machines
    vagrant global-status --prune -- same as above, but prunes invalid entries
    vagrant provision --debug -- use the debug flag to increase the verbosity of the output
    vagrant push -- yes, vagrant can be configured to deploy code!
    vagrant up --provision | tee provision.log -- Runs vagrant up, forces provisioning and logs all output to a file


### connect to ssh -X with Vagrant [run-graphical-programs-within-vagrantboxes](https://coderwall.com/p/ozhfva/run-graphical-programs-within-vagrantboxes)


### Example of a full vagrantfile
Vagrant files are a configureation files that allow to manage the machine.
``` bash
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "k-osint"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  
config.ssh.password = "kosint"
config.ssh.username = "kosint"
end
```
### Provisioning with ansible in a vagrant file 
``` bash
  # Run Ansible from the Vagrant VM
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook       = "playbook.yml"
    ansible.verbose        = false
    ansible.install        = true
  end
end
```

### Changing to zsh-shell [source](https://pablo.tools/posts/computers/custom-kali-box/)
#### Download the shell
```bash
tasks:
- name: Install missing packages
  apt:
    pkg:
      - zsh
    state: latest
    update_cache: yes
```
#### Set the shell
```bash
- name: Set shell of user root to zsh
  user:
    name: root
    shell: /bin/zsh
```

### Initialize metasploit [source](https://www.terasq.com/2019/03/building-kali-with-vagrant-ansible-p2/)
```bash
 - name: Initialize msfdb
     shell: "{{ item }}"
     with_items:
     - "update-rc.d postgresql enable"
     - "msfdb init"
     - "touch /usr/share/metasploit-framework/.initialized"
     args:
       creates: "/usr/share/metasploit-framework/.initialized"
       warn: false
```

### References:
- [vagrant-whonix-kali](https://github.com/j7k6/vagrant-whonix-kali/blob/master/Vagrantfile)
- [vagrantfile/ssh_settings](https://www.vagrantup.com/docs/vagrantfile/ssh_settings.html)
- [vagrant-provisioning-with-ansible](https://medium.com/@Joachim8675309/vagrant-provisioning-with-ansible-6dba6bca6290)
- [ansible/inventory/virtualbox](https://docs.ansible.com/ansible/latest/plugins/inventory/virtualbox.html)
- [ansible-dims-playbooks](https://ansible-dims-playbooks.readthedocs.io/en/latest/creatingvms.html)
- [Ansible Playbooks for Beginners - Hands-On](https://www.youtube.com/watch?v=Z01b9QZG0D0)
- [How To Ssh Into Linux Virtualbox](https://www.youtube.com/watch?v=ErzhbUusgdI)
- [https://www.virtualbox.org/manual](https://www.virtualbox.org/manual/ch08.html)
- [building-vagrant-machines-with-packer](https://www.gun.io/blog/building-vagrant-machines-with-packer)

![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)

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



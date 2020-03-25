![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)

#### ["The most beautiful flowers grow on the edge of the ravine"](http://www.achemenet.com/pdf/in-press/VAN-DER-SPEK_Cyrus_the_Great_Exiles_and_Foreign_Gods_June_2013.pdf) written on [Antiochus Cylinder](https://www.livius.org/sources/content/mesopotamian-chronicles-content/antiochus-cylinder/)

# Tutorials: Kali Linux ISO + Packer + Ansible + Vagrant + Docker + Virtualbox + Vmware

## Documentation:
- [Build a new ISO](https://github.com/cybern3tic/devops_notes/blob/master/tutorials/build_new_iso.md)
- [Packer](https://github.com/cybern3tic/devops_notes/blob/master/tutorials/packer.md)
- [Preseed](https://github.com/cybern3tic/devops_notes/blob/master/tutorials/preseed.md)
- [Vagrant](https://github.com/cybern3tic/devops_notes/blob/master/tutorials/vagrant.md)
- [Provisioning](https://github.com/cybern3tic/devops_notes/blob/master/tutorials/provisioning.md)
- [Ansible](https://github.com/cybern3tic/devops_notes/blob/master/tutorials/ansible.md)
- [Docker](https://github.com/cybern3tic/devops_notes/blob/master/tutorials/docker.md)
- [FAQ](https://github.com/cybern3tic/devops_notes/blob/master/tutorials/FAQ.md)

## username/password everywhere
```mindwarelab```

## Steps to build your own Vagrant Box flavor
- ISO creation keep it simple and follow the steps in [Build a new ISO](https://github.com/cybern3tic/devops_notes/blob/master/tutorials/build_new_iso.md)
- Preseed, you can change the root login or setup the user login, for simplicity keep the same password for the ssh for everything
- Packer, the configuration will require to manually log into the distro, and select the network.
  - when logged in you need to install ```sudo apt install openssh-server```
  - start the ssh service ```sudo service ssh start```
- Vagrant, the only thing you need to do is to add the box ```vagrant box add kore kore-virtualbox.box --name kore```
  - then, ```vagrant up```. 
  - In case there is some issue ```vagrant destroy``` to reset everything. 
  - be careful to add the ssh username and password to the vagrant file if you do ```vagrant init``` this create a new file and it does not contain your ssh credentials
- Ansible, configure all the packages of the different version, and tor network, specifically, this is where you make the distro different from the base box. 
  - select the [Kali metapackages](https://tools.kali.org/kali-metapackages), less is better
  - clone the git repo you will need 
  - install docker
  - install k8
  - configure the whonix-tor network to surn anonymously

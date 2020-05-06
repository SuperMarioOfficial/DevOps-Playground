### Provisioning with ansible playbook 
Provisioning with Ansible allows you to seamlessly transition into configuration management, orchestration and application deployment using the same simple, human readable, automation language.
- [ansible-basic-cheat-sheet](https://intellipaat.com/blog/tutorial/devops-tutorial/ansible-basic-cheat-sheet/)


### Install ansible
```apt-get install ansible -y```

### Basic commands 
- To check the connectivity of hosts ```	#ansible all -m ping```
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
- To stop a service	```#ansible all -m service -a “name= httpd state=”stopped”```
- To restart a service	```#ansible all -m service -a “name= httpd state=”restarted”```

### Ansible Glossary
The following Ansible-specific terms are largely used throughout this guide
- Control Machine / Node: a system where Ansible is installed and configured to connect and execute commands on nodes.
- Node: a server controlled by Ansible.
- Inventory File: a file that contains information about the servers Ansible controls, typically located at /etc/ansible/hosts.
- Playbook: a file containing a series of tasks to be executed on a remote server.
- Role: a collection of playbooks and other files that are relevant to a goal such as installing a web server.
- Play: a full Ansible run. A play can have several playbooks and roles, included from a single playbook that acts as entry point.

### Playbook Examples
- [pedantically_commented_playbook.yml/playbook.yml ](https://github.com/ogratwicklcs/pedantically_commented_playbook.yml/blob/master/playbook.yml)
- [cylab/kali-light/playbook.yml](https://gitlab.cylab.be/cylab/vagrant-boxes/blob/9abada07f232d9c50f90f94f9d33f9a90778ae19/kali-light/playbook.yml)
- [camjjack/kali-playbook.yml](https://github.com/camjjack/vagrant-ctf/blob/master/kali-playbook.yml)
- [NinjaStyle82/ansible-kali.yml](https://github.com/NinjaStyle82/ansible-kali/blob/master/ansible-kali.yml)


### Update && Upgrade
```
  - name: dist-upgrade
    apt:
        upgrade: dist
        update_cache: yes
        purge: yes
        autoremove: yes
        autoclean: yes
```
### Install packages [kali-metapackages](https://tools.kali.org/kali-metapackages)
```
  - name: install packages
    apt:
      name: "{{ packages }}"
    vars:
      packages:
      - python-pip
      - python3-pip
      - python3-setuptools 
      - python3-wheel
```

### clone from git [Documentation](https://docs.ansible.com/ansible/latest/modules/git_module.html)
- [OSINT awesome git list](https://awesomeopensource.com/projects/osint)
```
- name: clone repos
- git:
    	repo: "https://github.com/SuperMarioOfficial/Build-your-own-vagrant.box.git"
    	dest: ~/Desktop
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
- [provision-multiple-machines-in-parallel-with-vagrant-and-ansible](https://martincarstenbach.wordpress.com/2019/04/11/ansible-tipsntricks-provision-multiple-machines-in-parallel-with-vagrant-and-ansible/)
- [provisioning-a-virtual-machine-with-ansible](https://spaceweb.nl/provisioning-a-virtual-machine-with-ansible/)
- [introduction-to-ansible-tutorial](https://www.poftut.com/introduction-to-ansible-tutorial/)
- [ansible-system-updates](https://www.redpill-linpro.com/sysadvent/2017/12/24/ansible-system-updates.html)
- [Ansible Automation | Ansible Adhoc Commands and Configuration](https://www.youtube.com/watch?v=lRwGkO3PtB8)
- [ansible-tutorial guru99](https://www.guru99.com/ansible-tutorial.html)
- [Official introduction-to-ansible](https://www.ansible.com/resources/webinars-training/introduction-to-ansible)
- [Using Ansible for system updates](https://www.redpill-linpro.com/sysadvent/2017/12/24/ansible-system-updates.html)
- [ansible/inventory/virtualbox](https://docs.ansible.com/ansible/latest/plugins/inventory/virtualbox.html)
- [ansible-dims-playbooks](https://ansible-dims-playbooks.readthedocs.io/en/latest/creatingvms.html)
- [Ansible Playbooks for Beginners - Hands-On](https://www.youtube.com/watch?v=Z01b9QZG0D0)


![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)

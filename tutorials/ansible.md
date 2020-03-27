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
- [kali-playbook.yml](https://github.com/camjjack/vagrant-ctf/blob/master/kali-playbook.yml)
- [kali-light/playbook.yml](https://gitlab.cylab.be/cylab/vagrant-boxes/blob/9abada07f232d9c50f90f94f9d33f9a90778ae19/kali-light/playbook.yml)

## Case studies
### Installing GoLang
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
### Adding docker and aptitude
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

### Update && Upgrade
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
### Install packages [kali-metapackages](https://tools.kali.org/kali-metapackages)
```
  - name: install packages
    apt:
      name: "{{ packages }}"
    vars:
      packages:
      - kali-tools-top10
      - kali-tools-exploitation
      - kali-tools-reverse-engineering
      - kali-tools-passwords
      - pwntools
    
```

### clone from git [Documentation](https://docs.ansible.com/ansible/latest/modules/git_module.html)
- [OSINT awesome git list](https://awesomeopensource.com/projects/osint)
```
- name: clone repos
- git:
    	repo: 'https://github.com/s0md3v/Photon.git'
    	dest: ~/Desktop/Photon
  become: yes
  become_method: sudo
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

## Vagrant
[Vagrant cloud](https://app.vagrantup.com/boxes/search)

## Basics: [source](https://linuxacademy.com/blog/linux/vagrant-cheat-sheet-get-started-with-vagrant/)
- ```vagrant box add mindwarelab/<boxname> --provider virtualbox ```
- ```vagrant init --minimal```
- ```vagrant up --provision ```
- ```vagrant halt```
- ```vagrant reload --provision```

### Vagrant provision command
- to find the name tpye ```vagrant global-status```
	-```vagrant provision default```
	
### List of commands
```vagrant init <boxpath> -- Initialize Vagrant with a specific box. To find a box, go to the public Vagrant box catalog. When you find one you like, just replace it's name with boxpath. For example, vagrant init ubuntu/trusty64.
    vagrant up -- starts vagrant environment (also provisions only on the FIRST vagrant up)
    vagrant resume -- resume a suspended machine (vagrant up works just fine for this as well)
    vagrant provision -- forces reprovisioning of the vagrant machine
    vagrant reload -- restarts vagrant machine, loads new Vagrantfile configuration
    vagrant reload --provision -- restart the virtual machine and force provisioning
    vagrant ssh -- connects to machine via SSH
    vagrant ssh <boxname> -- If you give your box a name in your Vagrantfile, you can ssh into it with boxname. Works from any directory.
    vagrant halt -- stops the vagrant machine
    vagrant suspend -- suspends a virtual machine (remembers state)
    vagrant destroy -- stops and deletes all traces of the vagrant machine
    vagrant destroy -f -- same as above, without confirmation
    vagrant box list -- see a list of all installed boxes on your computer
    vagrant box add <name> <url> -- download a box image to your computer
    vagrant box outdated -- check for updates vagrant box update
    vagrant boxes remove <name> -- deletes a box from the machine
    vagrant package -- packages a running virtualbox env in a reusable box
    vagrant snapshot save [options] [vm-name] <name> -- vm-name is often default. Allows us to save so that we can rollback at a later time
    vagrant -v -- get the vagrant version
    vagrant status -- outputs status of the vagrant machine
    vagrant global-status -- outputs status of all vagrant machines
    vagrant global-status --prune -- same as above, but prunes invalid entries
    vagrant provision --debug -- use the debug flag to increase the verbosity of the output
    vagrant push -- yes, vagrant can be configured to deploy code!
    vagrant up --provision | tee provision.log -- Runs vagrant up, forces provisioning and logs all output to a file
```

### connect to ssh -X with Vagrant [run-graphical-programs-within-vagrantboxes](https://coderwall.com/p/ozhfva/run-graphical-programs-within-vagrantboxes)

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

### Errors: 
- ```The SSH command responded with a non-zero exit status. ```
	- https://askubuntu.com/questions/7477/how-can-i-add-a-new-user-as-sudoer-using-the-command-line
	- ```sh -c "echo 'mindwarelab ALL=NOPASSWD: ALL' >> /etc/sudoers"```

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

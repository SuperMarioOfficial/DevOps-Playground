# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
        vb.name = "htb"
    end
  config.vm.box = "htb"
  config.ssh.username = "mindwarelab"
  config.ssh.password = "mindwarelab"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: <<-SHELL
     apt-get update -y && apt-get full-upgrade -y
     apt-get dist-upgrade --dry-run -y
     apt-get install git -y
   SHELL

  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/install_docker.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/install_ansible.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/install_osquery.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/tor.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/virtualbox.sh"

   config.vm.provision "ansible" do |ansible|
    ansible.playbook       = "playbook.yml"
    ansible.verbose        = "v"
  end
end

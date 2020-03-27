# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
        vb.name = "base"
    end
  config.vm.box = "kore"
  config.ssh.username = "mindwarelab"
  config.ssh.password = "mindwarelab"

  config.vm.provision "shell", inline: <<-SHELL
     apt-get update -y && apt-get full-upgrade -y
     apt-get dist-upgrade --dry-run -y
   SHELL

  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/install_docker.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/install_ansible.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/install_osquery.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/tor.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/cleanup.sh"

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook       = "playbook.yml"
    ansible.verbose        = true
    ansible.install        = true
  end
end

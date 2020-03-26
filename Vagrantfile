# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
        vb.name = "base"
    end
  config.vm.box = "kore"
  config.vm.box_check_update = false
  config.ssh.username = "mindwarelab"
  config.ssh.password = "mindwarelab"

  config.vm.provision "shell", inline: <<-SHELL
     apt-get update -y && apt-get full-upgrade -y
     apt-get dist-upgrade --dry-run -y
     apt-get install zsh -y
   SHELL

  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/install_docker.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/install_ansible.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/install_osquery.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/tor.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/SuperMarioOfficial/devops_tutorials/master/scripts/cleanup.sh"
end


# NEED TO BE TESTED
  
	#config.vm.provider :virtualbox do |vb|
	#vb.customize 	["modifyvm",:id,"--memory","6000"]
	#vb.customize 	["modifyvm",:id,"--vram","128"]
	#vb.customize    ["modifyvm",:id,"--cpus","3"]
	#vb.customize 	["modifyvm",:id,"--audio","none"]
	#vb.customize 	["modifyvm",:id,"--nic1", "nat"]
	#vb.customize 	["modifyvm",:id,"--nic2", "intnet"]
	#vb.customize 	["modifyvm",:id,"--intnet2", "Whonix"]
	#vb.customize 	["modifyvm",:id,"--accelerate3d", "off"]
	#vb.customize    ["modifyvm",:id,"--usb", "on"]
	#vb.customize    ["modifyvm",:id,"--graphicscontroller", "vmsvga"]
	#vb.customize 	["modifyvm",:id,"--clipboard-mode", "bidirectional"]
	#vb.customize    ["modifyvm",:id,"--draganddrop", "bidirectional"]
	#end	



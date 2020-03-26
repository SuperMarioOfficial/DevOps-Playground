# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "kore"
  config.vm.box_check_update = false
  config.ssh.username = "mindwarelab"
  config.ssh.password = "mindwarelab"

  config.vm.provision "shell", inline: <<-SHELL
     apt-get update -y && apt-get full-upgrade -y
     apt-get dist-upgrade --dry-run -y
     apt-get install zsh -y
	
     export OSQUERY_KEY=1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
     apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $OSQUERY_KEY
     apt-get install software-properties-common  -y
     apt-get update  -y
     add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'
     apt-get update  -y
     apt-get install osquery  -y
   SHELL

  config.vm.provision "shell", path: "https://raw.githubusercontent.com/cybern3tic/devops_tutorials/master/scripts/ansible_deb.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/cybern3tic/devops_tutorials/master/scripts/tor.sh"
end
  
  #config.vm.provision "shell", path: "https://raw.githubusercontent.com/cybern3tic/devops_tutorials/master/scripts/cleanup.sh"
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



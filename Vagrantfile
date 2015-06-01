VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do | config |
	config.vm.provider "hyperv"
	config.vm.provider "virtualbox"
	config.vm.box = "ericmann/trusty64"
	config.vm.hostname = "railpagevm"
	config.vm.network "public_network", type: "dhcp"
	config.vm.synced_folder ".", "/vagrant", disabled: true
	config.vm.provision "shell", path: "setup.sh"
	
	config.ssh.username = "vagrant"
	
	config.vm.define "railpagevm" do | railpagevm |
	end
	
	config.vm.provider :virtualbox do | vb |
		vb.customize ["modifyvm", :id, "--memory", "512"]
		vb.name = "railpagevm"
	end
end
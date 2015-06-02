VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do | config |
	if Vagrant.has_plugin?("vagrant-proxyconf")
		config.proxy.http  = "http://10.142.204.58:8080"
		config.proxy.https = "http://10.142.204.58:8080"
		config.proxy.no_proxy = 'localhost,127.0.0.1'
	end
	
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
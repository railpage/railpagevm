VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "ericmann/trusty64"
	config.vm.hostname = "railpagevm"
	config.vm.network "public_network", type: "dhcp"
	
	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "1024"]
	end
end
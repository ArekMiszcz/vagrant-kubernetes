servers = [
    {
        :name => "master",
        :type => "master",
        :box => "debian/stretch64",
        :box_version => "9.9.1",
        :eth1 => "192.168.2.2",
        :mem => "2048",
        :cpu => "2"
    },
    {
        :name => "node-1",
        :type => "node",
        :box => "debian/stretch64",
        :box_version => "9.9.1",
        :eth1 => "192.168.2.3",
        :mem => "2048",
        :cpu => "2"
    },
    {
        :name => "node-2",
        :type => "node",
        :box => "debian/stretch64",
        :box_version => "9.9.1",
        :eth1 => "192.168.2.4",
        :mem => "2048",
        :cpu => "2"
    }
]

Vagrant.configure("2") do |config|
	servers.each do |opts|
		config.vm.define opts[:name] do |config|
			config.vm.box = opts[:box]
            		config.vm.box_version = opts[:box_version]
            		config.vm.hostname = opts[:name]
            		config.vm.network :private_network, ip: opts[:eth1]

            		config.vm.provider "virtualbox" do |v|
                		v.name = opts[:name]
                		v.customize ["modifyvm", :id, "--memory", opts[:mem]]
                		v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
            		end

			if opts[:type] == "master"
                		config.vm.network :forwarded_port, guest: 8001, host: 8001
				config.vm.network :forwarded_port, guest: 80, host: 8080
				config.vm.network :forwarded_port, guest: 443, host: 8443
            		end
		end
	end  
end

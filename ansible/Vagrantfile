# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    # Define VMs with static private IP addresses, vcpu, memory and vagrant-box.
      boxes = [
        {
          :name => "web1.demo.com",
          :box => "ubuntu/focal64",
          :ram => 1024,
          :vcpu => 1,
          :ip => "192.168.56.15"
        },
        {
          :name => "web2.demo.com",
          :box => "ubuntu/focal64",
          :ram => 1024,
          :vcpu => 1,
          :ip => "192.168.56.16"
        },
        {
          :name => "ansible-host",
          :box => "ubuntu/focal64",
          :ram => 4096,
          :vcpu => 1,
          :ip => "192.168.56.17"
        },
        {
          :name => "web3.demo.com",
          :box => "generic/centos8",
          :ram => 1024,
          :vcpu => 1,
          :ip => "192.168.56.18"
        }
      ]
    
      # Provision each of the VMs.
      boxes.each do |opts|
        config.vm.define opts[:name] do |config|
          config.vm.synced_folder ".", "/opt/vagrant", id: "vagrant-root", disabled: true
          config.ssh.insert_key = false
          config.vm.box = opts[:box]
          config.vm.hostname = opts[:name]
          config.vm.provider :virtualbox do |v|
            v.memory = opts[:ram]
            v.cpus = opts[:vcpu]
          end
          config.vm.network :private_network, ip: opts[:ip]
          config.vm.provision :file do |file|
             file.source     = 'key_gen.sh'
             file.destination    = '/home/vagrant/'
            end
          config.vm.provision "shell", path: "bootstrap.sh"

        end
    end
end
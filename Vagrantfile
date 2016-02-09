Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--ostype", "RedHat_64"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]
    v.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.define :centos do |dev|
    dev.vm.box = "centos/7"
    dev.vm.hostname = "centdev"
    dev.vm.network :private_network, ip: "192.168.33.9", virtualbox__intnet: "intnet"
    dev.vm.provision :itamae do |config|
      config.shell = "/bin/sh"
      config.sudo = true
      config.yaml = "nodes/development.yml"
      config.recipes = "roles/development.rb"
    end
  end

  config.vm.define :ubuntu do |dev|
    dev.vm.box = "ubuntu/trusty64"
    dev.vm.hostname = "ubuntudev"
    dev.vm.network :private_network, ip: "192.168.33.10", virtualbox__intnet: "intnet"
    dev.vm.provision :itamae do |config|
      config.shell = "/bin/sh"
      config.sudo = true
      config.yaml = "nodes/development.yml"
      config.recipes = "roles/development.rb"
    end
  end
end

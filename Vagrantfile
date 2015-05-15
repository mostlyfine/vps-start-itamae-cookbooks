Vagrant.configure(2) do |config|
  config.vm.box = "chef/centos-7.0"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--ostype", "RedHat_64"]
  end
end

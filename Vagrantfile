Vagrant.configure(2) do |config|
  config.vm.box = "chef/centos-7.0"
#   config.vm.box = "ubuntu/trusty64"
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--ostype", "RedHat_64"]
  end
  config.vm.provision :itamae do |config|
    config.sudo = true
    config.yaml = "roles/development.yml"
    config.recipes = %w{
      cookbooks/system/default.rb
      cookbooks/users/default.rb
      cookbooks/nginx/install.rb
      cookbooks/redis/default.rb
      cookbooks/mongodb/default.rb
      cookbooks/mysql/community.rb
      cookbooks/plenv/default.rb
      cookbooks/rbenv/default.rb
      cookbooks/ndenv/default.rb
    }
  end
end

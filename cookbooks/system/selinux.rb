case node[:platform]
when /centos|redhat|fedora/
  execute "setenforce 0" do
    only_if "getenforce | grep Enforcing"
  end
  remote_file "/etc/selinux/config" do
    only_if "test -e /etc/selinux/config"
  end
end



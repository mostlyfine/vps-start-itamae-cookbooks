case node[:platform]
when /centos|redhat|fedora/
  group node[:admin_group]

  template '/etc/sudoers.d/admin' do
    owner 'root'
    group 'root'
  end
end

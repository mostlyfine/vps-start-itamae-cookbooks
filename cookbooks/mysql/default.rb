case node[:platform]
when /centos|redhat|fedora/
  package "mysql55-devel"
  package "mysql55-server"
  package "mysql55"

  service "mysqld" do
    action [:enable, :start]
  end

when /ubuntu|debian/
  package "mysql-server"

  service "mysql" do
    action [:enable, :start]
  end
end


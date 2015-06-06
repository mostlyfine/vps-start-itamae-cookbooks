case node[:platform]

when /centos|redhat|fedora/
  remote_file "/etc/yum.repos.d/mysql-community.repo"
  remote_file "/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql"

  package "mysql-community-server"

  service "mysqld" do
    action [:enable, :start]
  end

when /ubuntu|debian/
  package "mysql-server"

  service "mysql" do
    action [:enable, :start]
  end
end

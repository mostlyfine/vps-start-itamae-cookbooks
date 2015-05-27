case node[:platform]
when /centos|redhat/
  remote_file "/etc/yum.repos.d/mysql-community.repo"
  remote_file "/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql"
end

package "mysql-community-server"

service "mysqld" do
  action [:enable, :start]
end


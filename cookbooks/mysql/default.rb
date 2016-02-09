os_version = node[:platform_version].to_i
db_version = node[:mysql] && node[:mysql][:version] || '5.6'
db_version = db_version.to_s.gsub(/\./, '')

case node[:platform]
when /centos|redhat/
  %w{mariadb-libs mysql}.each do |pkg|
    package pkg do
      action [:remove]
    end
  end

  execute "install mysql community repository" do
    command "rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el#{os_version}-5.noarch.rpm"
    not_if "rpm -qa | grep mysql-community"
  end

  %w{mysql-community-server mysql-community-devel}.each do |mysql|
    package mysql do
      options "--enablerepo=mysql#{db_version}-community"
    end
  end

  service "mysqld" do
    action [:enable, :start]
  end

when /ubuntu|debian/
  package "mysql-server"

  service "mysql" do
    action [:enable, :start]
  end
end


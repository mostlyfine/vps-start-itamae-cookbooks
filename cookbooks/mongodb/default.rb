case node[:platform]

when /centos|redhat|fedora/
  remote_file "/etc/yum.repos.d/mongo.repo"

when /ubuntu|debian/
  execute "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10"
  remote_file "/etc/apt/sources.list.d/mongodb.list"
  execute "apt-get update"
end

package "mongodb-org"

service "mongod" do
  action [:enable, :start]
end

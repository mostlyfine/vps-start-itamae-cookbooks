case node[:platform]
when /centos|redhat/
    remote_file "/etc/yum.repos.d/mongo.repo"
end

package "mongodb-org"

service "mongod" do
  action [:enable, :start]
end

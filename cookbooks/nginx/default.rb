case node[:platform]
when /centos|redhat/
    remote_file "/etc/yum.repos.d/nginx.repo"
end

package "nginx"

service "nginx" do
  action [:enable, :start]
end

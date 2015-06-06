case node[:platform]

when /centos|redhat|fedora/
  remote_file "/etc/yum.repos.d/nginx.repo"

when /ubuntu|debian/
  execute "wget -O - http://nginx.org/keys/nginx_signing.key | sudo apt-key add -"
  remote_file "/etc/apt/sources.list.d/nginx.list"
  execute "apt-get update"
end

package "nginx"

service "nginx" do
  action [:enable, :start]
end

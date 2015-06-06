case node[:platform]

when /centos|redhat|fedora/
  include_recipe "epel.rb"

  package "redis"

  service "redis" do
    action [:enable, :start]
  end

when /ubuntu|debian/
  package "redis-server"

  service "redis-server" do
    action [:enable, :start]
  end
end


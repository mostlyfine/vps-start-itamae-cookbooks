include_recipe "epel.rb"

package "redis"

service "redis" do
  action [:enable, :start]
end

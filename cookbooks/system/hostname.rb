file "/etc/sysconfig/network" do
  action :edit
  block do |content|
    content.gsub!(/^NETWORKING.+$/, "NETWORKING=#{node[:hostname]}")
    content << "NETWORKING=#{node[:hostname]}" unless content.index('NETWORKING')
  end
  only_if node[:hostname]
end

execute "hostname #{node[:hostname]}" do
  only_if node[:hostname]
end

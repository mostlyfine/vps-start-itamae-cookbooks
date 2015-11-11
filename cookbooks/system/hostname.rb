if node[:hostname]
  execute "hostname #{node[:hostname]}"
  file "/etc/sysconfig/network" do
    action :edit
    block do |content|
      content.gsub!(/^NETWORKING.+$/, "NETWORKING=#{node[:hostname]}")
      content << "NETWORKING=#{node[:hostname]}" unless content.index('NETWORKING')
    end
    only_if "test -f /etc/sysconfig/network"
  end
end

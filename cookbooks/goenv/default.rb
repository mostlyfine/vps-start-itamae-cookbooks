goenv_user = node[:goenv] && node[:goenv][:user] || "root"
goenv_root = node[:goenv] && node[:goenv][:path] || "/usr/local/goenv"

git goenv_root do
  repository "git://github.com/wfarr/goenv.git"
  user goenv_user
end

template "/etc/profile.d/goenv.sh" do
  owner "root"
  group "root"
  mode "0644"
  variables goenv_root: goenv_root
end

node[:goenv][:versions].each do |version|
  execute "install golang" do
    command ". /etc/profile.d/goenv.sh && goenv install #{version}"
    not_if "test `. /etc/profile.d/goenv.sh && goenv versions | grep '#{version}' -c` != 0"
  end
end

execute "set global go version" do
  command ". /etc/profile.d/goenv.sh && goenv global #{node[:goenv][:global]} && goenv rehash"
  not_if node[:goenv][:global]
end

node[:goenv][:packages].each do |pkg|
  execute ". /etc/profile.d/goenv.sh && GOPATH=#{goenv_root} && go get #{pkg}"
end

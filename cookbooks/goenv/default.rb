goenv_user = node[:goenv][:user] || "root"
goenv_root = node[:goenv][:path] || "/home/#{goenv_user}/.goenv"

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
  execute ". /etc/profile.d/goenv.sh && goenv install #{version}" do
    not_if "test `. /etc/profile.d/goenv.sh && goenv versions | grep '#{version}' -c` != 0"
  end
end

execute ". /etc/profile.d/goenv.sh && goenv global #{node[:goenv][:global]} && goenv rehash" do
  not_if node[:goenv][:global]
end

node[:goenv][:packages].each do |pkg|
  execute ". /etc/profile.d/goenv.sh && GOPATH=#{goenv_root} && go get #{pkg}"
end

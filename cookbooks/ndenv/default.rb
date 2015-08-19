ndenv_user = node[:ndenv][:user] || "root"
ndenv_root = node[:ndenv][:path] || "/home/#{ndenv_user}/.ndenv"

git ndenv_root do
  repository "git://github.com/riywo/ndenv.git"
  user ndenv_user
end

git "#{ndenv_root}/plugins/node-build" do
  repository "git://github.com/riywo/node-build.git"
  user ndenv_user
end

template "/etc/profile.d/ndenv.sh" do
  owner "root"
  group "root"
  mode "0644"
  variables ndenv_root: ndenv_root
end

node[:ndenv][:versions].each do |version|
  execute ". /etc/profile.d/ndenv.sh && ndenv install #{version}" do
    not_if "test `. /etc/profile.d/ndenv.sh && ndenv versions | grep '#{version}' -c` != 0"
  end
end

execute ". /etc/profile.d/ndenv.sh && ndenv global #{node[:ndenv][:global]} && ndenv rehash" do
  not_if node[:ndenv][:global]
end

plenv_user = node[:plenv] && node[:plenv][:user] || "root"
plenv_root = node[:plenv] && node[:plenv][:path] || "/usr/local/plenv"

include_recipe "./common.rb"

git plenv_root do
  repository "git://github.com/tokuhirom/plenv.git"
  user plenv_user
end

git "#{plenv_root}/plugins/perl-build" do
  repository "git://github.com/tokuhirom/perl-build.git"
  user plenv_user
end

git "#{plenv_root}/plugins/plenv-update" do
  repository "git://github.com/dayflower/plenv-update.git"
  user plenv_user
end

template "/etc/profile.d/plenv.sh" do
  owner "root"
  group "root"
  mode "0644"
  variables plenv_root: plenv_root
end

node[:plenv][:versions].each do |version|
  execute ". /etc/profile.d/plenv.sh && plenv install #{version}" do
    not_if "test `. /etc/profile.d/plenv.sh && plenv versions | grep '#{version}' -c` != 0"
  end
end

if node[:plenv][:global]
  execute ". /etc/profile.d/plenv.sh && plenv global #{node[:plenv][:global]} && plenv rehash && plenv install-cpanm && plenv exec cpanm Carton"
end

node[:plenv][:cpans].each do |cpan|
  execute ". /etc/profile.d/plenv.sh && cpanm #{cpan} "
end

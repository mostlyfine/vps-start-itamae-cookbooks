rbenv_user = node[:rbenv][:user] || "root"
rbenv_root = node[:rbenv][:path] || "/home/#{rbenv_user}/.rbenv"

include_recipe "./common.rb"

git rbenv_root do
  repository "git://github.com/sstephenson/rbenv.git"
  user rbenv_user
end

git "#{rbenv_root}/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  user rbenv_user
end

template "/etc/profile.d/rbenv.sh" do
  owner "root"
  group "root"
  mode "0644"
  variables rbenv_root: rbenv_root
end

node[:rbenv][:versions].each do |version|
  execute ". /etc/profile.d/rbenv.sh && CONFIGURE_OPTS='--disable-install-doc' rbenv install #{version}" do
    not_if "test `. /etc/profile.d/rbenv.sh && rbenv versions | grep '#{version}' -c` != 0"
  end
end

execute ". /etc/profile.d/rbenv.sh && rbenv global #{node[:rbenv][:global]} && rbenv rehash" do
  not_if node[:rbenv][:global]
end

node[:rbenv][:gems].each do |gem|
  execute ". /etc/profile.d/rbenv.sh && gem install #{gem}; rbenv rehash" do
    not_if ". /etc/profile.d/rbenv.sh && gem list | grep #{gem}"
  end
end



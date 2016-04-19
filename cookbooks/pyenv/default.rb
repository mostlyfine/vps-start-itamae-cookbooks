pyenv_user = node[:pyenv] && node[:pyenv][:user] || "root"
pyenv_root = node[:pyenv] && node[:pyenv][:path] || "/usr/local/pyenv"

git pyenv_root do
  repository "https://github.com/yyuu/pyenv.git"
  user pyenv_user
end

git "#{pyenv_root}/plugins/pyenv-virtualenv" do
  repository "git://github.com/yyuu/pyenv-virtualenv.git"
  user pyenv_user
end

template "/etc/profile.d/pyenv.sh" do
  owner "root"
  group "root"
  mode "0644"
  variables pyenv_root: pyenv_root
end

node[:pyenv][:versions].each do |version|
  execute ". /etc/profile.d/pyenv.sh && pyenv install #{version}" do
    not_if "test `. /etc/profile.d/pyenv.sh && pyenv versions | grep '#{version}' -c` != 0"
  end
end

execute ". /etc/profile.d/pyenv.sh && pyenv global #{node[:pyenv][:global]} && pyenv rehash" do
  not_if node[:pyenv][:global]
end

node[:pyenv][:packages].each do |pkg|
  execute ". /etc/profile.d/pyenv.sh && pip install #{pkg}; pyenv rehash" do
    not_if ". /etc/profile.d/pyenv.sh && pip list | grep #{pkg}"
  end
end


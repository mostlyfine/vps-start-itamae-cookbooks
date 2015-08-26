%w(
git
wget
curl
zsh
screen
tmux
lsof
dstat
ctags
unzip
).each do |pkg|
  package pkg
end

case node[:platform]
when /centos|redhat|fedora/
  package "vim-enhanced"
  execute "rpm -ivh http://pkgs.repoforge.org/keychain/keychain-2.7.0-1.el6.rf.noarch.rpm" do
    not_if "rpm -qa | grep keychain"
  end
when /ubuntu|debian/
  package "vim"
  package "keychain"
end

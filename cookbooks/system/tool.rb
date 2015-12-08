%w(
git
wget
curl
zsh
nkf
screen
tmux
lsof
dstat
ctags
unzip
jq
).each do |pkg|
  package pkg
end

case node[:platform]
when /centos|redhat|fedora/
  package "vim-enhanced"
  execute "rpm -ivh http://pkgs.repoforge.org/keychain/keychain-2.7.0-1.el6.rf.noarch.rpm" do
    not_if "rpm -qa | grep keychain"
  end

  execute "rpm -ivh http://apt.sw.be/redhat/el6/en/x86_64/rpmforge/RPMS/lv-4.51-1.el6.rf.x86_64.rpm" do
    not_if "rpm -qa | grep lv"
  end
when /ubuntu|debian/
  package "vim"
  package "keychain"
end


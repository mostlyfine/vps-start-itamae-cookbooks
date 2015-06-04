%w(
git
wget
curl
vim
zsh
screen
tmux
lsof
dstat
).each do |pkg|
  package pkg
end

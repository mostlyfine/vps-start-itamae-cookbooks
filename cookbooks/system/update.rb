case node[:platform]
when /centos|fedora|redhat/
  execute "yum -y update"
when /ubuntu|debian/
  execute "apt-get update -y"
end

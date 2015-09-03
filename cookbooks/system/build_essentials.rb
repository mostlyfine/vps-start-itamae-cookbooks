case node[:platform]
when /centos|redhat|fedora/
  execute "yum groupinstall -y \"Development Tools\""
  execute "yum install kernel-devel kernel-headers"

when /ubuntu|debian/
  package "build-essential"
end

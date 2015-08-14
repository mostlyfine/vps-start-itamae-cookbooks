packages = case node[:platform]
           when /centos|redhat|fedora/
             %w{
               gcc
               wget
               openssl-devel
               pcre-devel
               zlib-devel
               gd-devel
             }
           end

packages.each do |pkg|
  package pkg
end


packages = case node[:platform]
when /ubuntu|debian/
  %w{
  gcc
  git
  wget
  autoconf
  bison
  build-essential
  libssl-dev
  libyaml-dev
  libreadline6-dev
  zlib1g-dev
  libncurses5-dev
  libffi-dev
  }
when /centos|redhat|fedora/
  %w{
  gcc
  git
  wget
  gdbm-devel
  openssl-devel
  libyaml-devel
  readline-devel
  zlib-devel
  ncurses-devel
  libffi-devel
  pcre-devel
  }
end

packages.each{|pkg| package pkg }

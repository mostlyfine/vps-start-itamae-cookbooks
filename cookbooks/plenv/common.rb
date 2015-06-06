packages = case node[:platform]
           when %r(redhat|fedora)
             %w{
              git
              perl-devel
              bzip2-devel
              zlib-devel
              openssl-devel
              readline-devel
              ncurses-devel
              gdbm-devel
              libffi-devel
              libyaml-devel
              libicu-devel
              libxml2-devel
              libxslt-devel
              expat-devel
              tk-devel
             }
           when %r(debian|ubuntu)
             %w{
              git
              autoconf
              build-essential
              libssl-dev
              libcurl4-openssl-dev
              libyaml-dev
              zlib1g-dev
              libicu-dev
              libreadline6-dev
              libreadline6-dev
              libncurses5-dev
              libffi-dev
             }
           end

packages.each do |pkg|
  package pkg
end

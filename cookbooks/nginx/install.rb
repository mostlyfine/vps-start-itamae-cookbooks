include_recipe "./common.rb"

version = node[:nginx] && node[:nginx][:version] ? node[:nginx][:version] : "1.9.1"
srcfile = "/usr/local/src/nginx-#{version}.tar.gz"
srcdir = "/usr/local/src/nginx-#{version}"

execute "download #{srcfile}" do
  command "wget http://nginx.org/download/nginx-#{version}.tar.gz -O #{srcfile}"
  not_if File.exist? srcfile
end

execute "extract #{srcfile}" do
  command "tar xzf #{srcfile} -C /usr/local/src"
  not_if File.exist? srcdir
end

execute "configure #{srcdir}" do
  command <<EOS
cd #{srcdir} && ./configure \
--prefix=/etc/nginx \
--sbin-path=/usr/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/subsys/nginx \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--user=nginx \
--group=nginx \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-http_image_filter_module \
--with-threads \
--with-mail \
--with-mail_ssl_module \
--with-file-aio
EOS
  not_if File.exist? "#{srcdir}/Makefile"
end

execute "make install #{srcdir}" do
  command "cd #{srcdir} && make && make install"
  not_if File.exist? "/usr/sbin/nginx"
end

user "nginx" do
  home "/etc/nginx"
  shell "/sbin/nologin"
  not_if "grep nginx /etc/passwd"
end

remote_file "/etc/init.d/nginx" do
  owner "root"
  group "root"
  mode "0755"
end

service "nginx" do
  action [:enable, :start]
end

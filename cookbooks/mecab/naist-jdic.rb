version = "0.6.3b-20111013"
srcfile = "mecab-naist-jdic-#{version}.tar.gz"

execute "download naist-jdic" do
  command "wget http://iij.dl.sourceforge.jp/naist-jdic/53500/#{srcfile} -O /usr/local/src/#{srcfile}"
  not_if "test -f /usr/local/src/#{srcfile}"
end

execute "extract naist-jdic" do
  command "tar xvzf /usr/local/src/#{srcfile} -C /usr/local/src"
  not_if "test -d /usr/local/src/mecab-naist-jdic-#{version}"
end

execute "configure naist-jdic" do
 command <<EOS
cd /usr/local/src/mecab-naist-jdic-#{version} && \
./configure --with-charset=utf8 --with-mecab-config=/usr/bin/mecab-config && \
make && make install
EOS
  not_if "test -d /usr/lib64/mecab/dic/naist-jdic"
end

template "/etc/mecabrc" do
  owner "root"
  group "root"
  mode "0644"
  variables dicdir: "/usr/lib64/mecab/dic/naist-jdic"
end

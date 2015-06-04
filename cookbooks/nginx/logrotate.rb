remote_file "/etc/logrotate.d/nginx"

# テストで一回実行してみる
execute "logrotate -df /etc/logrotate.d/nginx"

service "crond" do
  action [:enable, :start]
end

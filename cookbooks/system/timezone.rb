file "/etc/localtime" do
  action :delete
  only_if "test -e /etc/localtime"
end

link "/etc/localtime" do
  to "/usr/share/zoneinfo/Asia/Tokyo"
  not_if "test -e /etc/localtime"
end

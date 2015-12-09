version = node[:gitbucket] && node[:gitbucket][:version] ? node[:gitbucket][:version] : "3.9"
home = node[:gitbucket] && node[:gitbucket][:home] ? node[:gitbucket][:home] : "/var/lib/tomcat/webapps"
server = node[:gitbucket] && node[:gitbucket][:server] ? node[:gitbucket][:server] : "tomcat"

package "java-1.8.0-openjdk"
package server
execute "wget https://github.com/takezoe/gitbucket/releases/download/#{version}/gitbucket.war -O #{home}/gitbucket.war" do
  not_if "test -f #{home}/gitbucket.war"
end

service server do
  action [:enable, :start]
end

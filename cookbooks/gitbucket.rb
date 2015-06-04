version = node[:gitbucket] && node[:gitbucket][:version] ? node[:gitbucket][:version] : "3.3"

package "java-1.8.0-openjdk"
execute "wget https://github.com/takezoe/gitbucket/releases/download/#{version}/gitbucket.war -O /usr/local/src/gitbucket.war"
execute "java -jar /usr/local/src/gitbucket.war &"

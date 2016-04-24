# Cookbook Name:: tomcat
# Recipe:: default
execute 'tomcat_owner' do
  user 'root'
  command "chown -R tomcat:tomcat /opt/apache-tomcat-7.0.69 && chmod +x /opt/apache-tomcat-7.0.69/bin/*.sh"
  action :nothing
end

user 'tomcat' do
  action :create
end

template "/home/tomcat/.bashrc" do
  source "bashrc.erb"
  mode "0644"
  owner "root"
  group "root"
end

package 'unzip' do
  package_name 'unzip'
  action :install
end

remote_file "/opt/apache-tomcat-7.0.69.zip" do
  source 'http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.zip'
  owner 'root'
  group 'root'
  mode 0755
  action :create
  not_if { ::File.file?("/opt/apache-tomcat-7.0.69.zip")}
end

execute 'tomcat_extract' do
  user 'root'
  command "unzip -o /opt/apache-tomcat-7.0.69.zip -d /opt"
  action :run
  not_if { ::File.directory?("/opt/apache-tomcat-7.0.69")}
  notifies :run, 'execute[tomcat_owner]', :immediately
end

template "/etc/init.d/tomcat" do
  source "tomcat_init.erb"
  mode "0755"
  owner "root"
  group "root"
end

template "/opt/apache-tomcat-7.0.69/conf/server.xml" do
  source "tomcat_server.erb"
  mode "0644"
  owner "tomcat"
  group "tomcat"
  variables({
    'tomcat_port' => node['tomcat']['tomcat_port']
})
end

service "tomcat" do
  supports :restart => true, :start => true, :stop => true, :status => false
  action [ :enable, :start ]
end

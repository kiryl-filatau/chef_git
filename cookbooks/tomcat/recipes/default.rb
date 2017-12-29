#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.



package 'java-1.7.0-openjdk-devel'

group 'tomcat'

user 'tomcat' do
  manage_home false
  group 'tomcat'
  shell '/bin/nologin'
  home '/opt/tomcat'
end

# remote_file '/tmp/apache-tomcat-8.5.24.tar.gz' do
#   source 'http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz'
# end

directory '/opt/tomcat' do
  action :create
  group 'tomcat'
end

#TODO : NOT DESIRED STATE
# execute "sudo tar xvf /tmp/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1"

#Extractin with tar cookbook v ~> 2.1.1
tar_extract 'http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.5.24/bin/apache-tomcat-8.5.24.tar.gz' do
  target_dir '/opt/tomcat/'
  creates '/opt/tomcat/bin/startup.sh'
  tar_flags [ '--strip-components=1' ]
end

#TODO : NOT DESIRED STATE
execute "sudo chgrp -R tomcat /opt/tomcat"

#TODO : NOT DESIRED STATE
execute "sudo chmod -R g+r /opt/tomcat/conf"

directory '/opt/tomcat/conf' do
  mode '0750'
end

#TODO : NOT DESIRED STATE
execute "sudo chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/"

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

#TODO : NOT DESIRED STATE
execute 'sudo systemctl daemon-reload'

# systemd_unit 'systemctl' do
#   action :reload
# end

service 'tomcat' do 
  action [:enable, :start]
end





#
# Cookbook Name:: terraform
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'nginx' do
  action :install
end

template "/var/www/html/index.nginx-debian.html" do
  source "nginx.erb"
  mode "0644"
  owner "root"
  group "root"
end

service "nginx" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end
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

template "/etc/nginx/nginx.conf" do
  source "nginx.erb"
  mode "0644"
  owner "root"
  group "root"
  variables({
    'node_ip' => ip_range
})
end
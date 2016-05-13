#
# Cookbook Name:: nginx
# Recipe:: default

ip_range = Array.new

search(:node, 'name:jboss*') do |ip|
    ip_range << ip["network"]["interfaces"]["eth1"]["addresses"].keys[1]
end

template "/etc/yum.repos.d/NGINX.repo" do
  source "nginx_repo.erb"
  mode "0644"
  owner "root"
  group "root"
end

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

template "/etc/nginx/conf.d/vhosts.conf" do
  source "vhosts.erb"
  mode "0644"
  owner "root"
  group "root"
  variables({
    'nginx_ip' => node["network"]["interfaces"]['eth1']["addresses"].keys[1]
})
end


service "nginx" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end

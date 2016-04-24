#
# Cookbook Name:: nginx
# Recipe:: default
template "/etc/yum.repos.d/NGINX.repo" do
  source "nginx_repo.erb"
  mode "0644"
  owner "root"
  group "root"
end

package 'nginx' do
  action :install
end

template "/etc/nginx/conf.d/default.conf" do
  source "nginx_config.erb"
  mode "0644"
  owner "root"
  group "root"
  variables({
    'nginx_port' => node['nginx']['nginx_port'],
    'jenkins_port' => node['jenkins']['jenkins_port'],
    'tomcat_port' => node['tomcat']['tomcat_port']
})
end

service "nginx" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end

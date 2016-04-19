#
# Cookbook Name:: jbosskf
# Recipe:: default

include_recipe 'java'

package 'unzip' do
  package_name 'unzip'
  action :install
end

user node[:jboss][:jboss_user] do
  action :create
end

group node[:jboss][:jboss_user] do
  action :create
  members node[:jboss][:jboss_user]
end

remote_file "#{node[:jboss][:tmp]}/#{node[:jboss][:jboss_zip]}" do
  source node[:jboss][:download_url]
  owner 'root'
  group 'root'
  mode 0755
  action :create
  not_if { ::File.file?("#{node[:jboss][:tmp]}/#{node[:jboss][:jboss_zip]}")}
end

execute 'jboss_extract' do
  user 'root'
  command "unzip -o #{node[:jboss][:tmp]}/#{node[:jboss][:jboss_zip]} -d #{node[:jboss][:jboss_home]}"
  action :run
  not_if { ::File.directory?("#{node[:jboss][:jboss_home]}/#{node[:jboss][:jboss_dir]}")}
end

remote_file "#{node[:jboss][:tmp]}/#{node[:jboss][:app_zip]}" do
  source node[:jboss][:download_app]
  owner 'root'
  group 'root'
  mode 0755
  action :create
  not_if { ::File.file?("#{node[:jboss][:tmp]}/#{node[:jboss][:app_zip]}")}
end

execute 'app_extract' do
  user 'root'
  command "unzip -o #{node[:jboss][:tmp]}/#{node[:jboss][:app_zip]} -d #{node[:jboss][:jboss_home]}/#{node[:jboss][:jboss_dir]}/server/default/deploy/"
  action :run
  not_if { ::File.directory?("#{node[:jboss][:jboss_home]}/#{node[:jboss][:jboss_dir]}/server/default/deploy/testweb")}
end

execute 'jboss_owner' do
  user 'root'
  command "chown -R #{node[:jboss][:jboss_user]}:#{node[:jboss][:jboss_user]} #{node[:jboss][:jboss_home]}/#{node[:jboss][:jboss_dir]} "
  action :run
end


template "/etc/init.d/jboss" do
  source "init_jboss.erb"
  mode "0755"
  owner "#{node[:jboss][:jboss_user]}"
  group "#{node[:jboss][:jboss_user]}"
  variables({
    :user => node[:jboss][:jboss_user],
    :home => node[:jboss][:jboss_home],
    :jboss_dir => node[:jboss][:jboss_dir],
    :ip => node[:jboss][:jboss_ip]
})
end

service "jboss" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end


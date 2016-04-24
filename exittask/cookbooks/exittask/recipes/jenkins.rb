# Cookbook Name:: jenkins
# Recipe:: default
execute 'jenkins_owner' do
  user 'root'
  command "chown -R jenkins:jenkins /var/lib/jenkins"
  action :nothing
end

template "/etc/yum.repos.d/jenkins.repo" do
  source "jenkins_repo.erb"
  mode "0644"
  owner "root"
  group "root"
end

package 'jenkins' do
  action :install
end

template "/etc/sysconfig/jenkins" do
  source "jenkins_config.erb"
  mode "0644"
  owner "root"
  group "root"
  variables({
    'jenkins_port' => node['jenkins']['jenkins_port'],
    'jenkins_ajp_port' => node['jenkins']['jenkins_ajp_port'],
    'jenkins_args' => node['jenkins']['jenkins_args']
})
end

remote_directory "/var/lib/jenkins" do
  source 'jenkins'
  owner 'jenkins'
  group 'jenkins'
  files_owner 'jenkins'
  files_group 'jenkins'
  mode 0755
  action :create
  notifies :run, 'execute[jenkins_owner]', :immediately
end

template "/etc/sudoers.d/jenkins" do
  source "jenkins_sudo.erb"
  mode "0644"
  owner "root"
  group "root"
end

package 'git' do
  action :install
end

service "jenkins" do
  supports :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end

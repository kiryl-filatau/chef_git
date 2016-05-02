action :install do
  package 'nginx' do
    package_name 'nginx'
    action :install
  end
end

action :setup do
  service 'nginx' do
    action :enable
  end
  template '/usr/share/nginx/html/index.html' do
    source "index.erb"
    mode "0755"
    owner "root"
    group "root"
    variables({
      :name => "#{new_resource.name}",
      :some_fun => "#{new_resource.some_fun}"
    })
  end
end

action :stop do 
  service 'nginx' do
    action :stop
  end
end

action :start do 
  service 'nginx' do
    action :start
  end
end

action :restart do 
  service 'nginx' do
    action :restart
  end
end

action :reload do 
  service 'nginx' do
    action :reload
  end
end

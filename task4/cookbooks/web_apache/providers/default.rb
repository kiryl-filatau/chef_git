action :install do
  package 'httpd' do
    package_name 'httpd'
    action :install
  end
end

action :setup  do
  service 'httpd' do
    action :enable
  end
  template 'var/www/error/noindex.html' do
    source "noindex.erb"
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
  service 'httpd' do
    action :stop
  end
end

action :start do 
  service 'httpd' do
    action :start
  end
end

action :restart do 
  service 'httpd' do
    action :restart
  end
end

action :reload do 
  service 'httpd' do
    action :reload
  end
end

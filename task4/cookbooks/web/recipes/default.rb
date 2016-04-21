# Cookbook Name:: web
# Recipe:: default
if node.role?('apache_web_server')
  include_recipe 'web_apache'
elsif node.role?('nginx_web_server')
  include_recipe 'web_nginx'
else
  puts "please try apache or nginx role"
end


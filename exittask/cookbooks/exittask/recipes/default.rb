# Cookbook Name:: exittask
# Recipe:: default

# ALL this cookbooks use attributes 'from exittask' cookbook!

include_recipe 'exittask::java'

include_recipe 'exittask::nginx'

include_recipe 'exittask::jenkins'

include_recipe 'exittask::tomcat'











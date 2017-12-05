# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "filatoff"
client_key               "#{current_dir}/filatoff.pem"
validation_client_name   "lollol-validator"
validation_key           "#{current_dir}/lollol-validator.pem"
chef_server_url          "https://api.chef.io/organizations/lollol"
cookbook_path            ["#{current_dir}/../cookbooks"]
knife[:editor]           = "vim"
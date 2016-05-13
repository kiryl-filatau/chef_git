# up.rb
require 'chef/provisioning'
require 'chef/provisioning/vagrant_driver'
with_driver "vagrant"
vagrant_box 'sbeliakou/centos-6.7-x86_64' do
  url 'https://atlas.hashicorp.com/sbeliakou/boxes/centos-6.7-x86_64'
end
with_machine_options :vagrant_options => {
  'vm.box' => 'sbeliakou/centos-6.7-x86_64',
  'vm.network' => ':private_network, type: "dhcp"'
}
machine_batch do
  1.upto(node["quantity"]) do |i|
    machine "jboss#{i}" do
      recipe 'chef_adv_task::java'
      recipe 'chef_adv_task::jboss'
    end
  end
  machine 'nginx' do
    recipe 'chef_adv_task::nginx'
  end
end
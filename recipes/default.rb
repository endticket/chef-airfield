#
# Cookbook Name:: app-airfield
# Recipe:: default
#
# Copyright 2015, Endticket
#
# All rights reserved - Do Not Redistribute
#
node.set['nodejs']['install_method'] = 'package'
include_recipe "nodejs"

git "/opt/airfield" do
  repository "https://github.com/emblica/airfield.git"
  action :sync
  user 'root'
  notifies :run, 'execute[npm install]', :immediately
end

execute 'npm install' do
  command 'npm install'
  cwd "/opt/airfield"
  action :nothing
end

template '/opt/airfield/settings.js' do
  source 'settings.js.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables({
   :admin_user => node['airfield']['admin_user'],
   :admin_pass => node['airfield']['admin_pass'],
   :listen_port => node['airfield']['listen_port'],
   :cookie_secret => node['airfield']['cookie_secret'],
   :session_secret => node['airfield']['session_secret'],
   :openstack => node['airfield']['openstack'],
   :os_user => node['airfield']['openstack_user'],
   :os_password => node['airfield']['openstack_password'],
   :os_tenant => node['airfield']['openstack_tenant'],
   :os_keystone_url => node['airfield']['openstack_keystone_url'],
   :os_nova_url => node['airfield']['openstack_nova_url'],
   :redis_port => node['airfield']['redis_port'],
   :redis_host => node['airfield']['redis_host']
     })
end

directory '/opt/airfield/public/img' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

user "airfield" do
  comment "airfield"
  system true
  shell "/bin/false"
end


directory '/opt/airfield/log' do
  owner 'airfield'
  group 'airfield'
  mode '0755'
  action :create
end

directory '/opt/airfield/scripts' do
  owner 'airfield'
  group 'airfield'
  mode '0755'
  action :create
end


cookbook_file "/opt/airfield/public/img/glyphicons-halflings.png" do
  source "glyphicons-halflings.png"
  mode 0644
end

cookbook_file "/opt/airfield/scripts/start" do
  source "upstart.start"
  mode 0755
end

cookbook_file "/etc/init/airfield.conf" do
  source "upstart.conf"
  mode 0644
end


service "airfield" do
  action [ :enable, :start ]
end



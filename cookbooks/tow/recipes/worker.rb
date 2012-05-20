# -*- mode: ruby -*-
# # vi: set ft=ruby :
#
# Cookbook Name:: tow
# Recipe:: worker
#

include_recipe "tow::prerequisites"

Chef::Log.info("====== Installing tow worker node =====")

screen_it(node[:tow][:username], "api", "cd /home/#{node[:tow][:username]}/tow/worker/lib && ruby worker.rb")

#template "/home/#{node[:wheel][:username]}/tow/etc/api.cfg" do
#    source "api.cfg.erb"
#    owner node[:wheel][:username]
#    group node[:wheel][:username]
#    action :create_if_missing
#    variables(
#        :ENABLED_SERVICES => node[:stack][:enabled_services],
#        :LIBVIRT_TYPE => node[:stack][:libvirt_type],
#        :MYSQL_HOST => node[:stack][:mysql][:host],
#        :MYSQL_USER => node[:stack][:mysql][:user],
#        :MYSQL_PASSWORD => node[:stack][:mysql][:password],
#        :RABBIT_HOST => node[:stack][:rabbit][:host],
#        :RABBIT_PASSWORD => node[:stack][:rabbit][:password],
#        :REPOS => node[:stack][:repos],
#        :DEVSTACK_BRANCH => node[:stack][:branch],
#        :BRANCHES => node[:stack][:branches]        
#    )
#end


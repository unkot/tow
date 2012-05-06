# -*- mode: ruby -*-
# # vi: set ft=ruby :
#
# Cookbook Name:: tow
# Recipe:: prerequisites
#

include_recipe "git::default"

# fixes CHEF-1699
ruby_block "reset group list" do
    block do
        Etc.endgrent
    end                
    action :nothing
end

Chef::Log.info("====== Installing tow prerequisites =====")

user node[:tow][:username] do
    comment "Wheel User"
    home "/home/#{node[:tow][:username]}"
    shell "/bin/bash"
    notifies :create, "ruby_block[reset group list]", :immediately
end

directory "/home/#{node[:tow][:username]}" do
    owner node[:tow][:username]
    group node[:tow][:username]
    mode "0755"
    action :create
end

directory "/home/#{node[:tow][:username]}/.ssh" do
    owner node[:tow][:username]
    group node[:tow][:username]
    mode "0755"
    action :create
end

cookbook_file "/home/#{node[:tow][:username]}/.ssh/config" do
    source "config"
    owner node[:tow][:username]
    group node[:tow][:username]
    action :create_if_missing
end

cookbook_file "/home/#{node[:tow][:username]}/.ssh/id_rsa" do
    source "id_rsa"
    owner node[:tow][:username]
    group node[:tow][:username]
    mode "0600"
    action :create_if_missing
end

cookbook_file "/home/#{node[:tow][:username]}/.ssh/id_rsa.pub" do
    source "id_rsa.pub"
    owner node[:tow][:username]
    group node[:tow][:username]
    action :create_if_missing
end

git "/home/#{node[:tow][:username]}/tow" do
    repository node[:tow][:repository_url]
    reference "#{node[:tow][:branch]}"
    action :sync
    user node[:tow][:username]
end

directory "/home/#{node[:tow][:username]}/tow/etc" do
    owner node[:tow][:username]
    group node[:tow][:username]
    mode "0755"
    action :create
end


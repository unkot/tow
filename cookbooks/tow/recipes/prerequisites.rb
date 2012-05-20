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

user node[:tow][:username] do
    comment "Tow User"
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

cookbook_file "/home/#{node[:tow][:username]}/.ssh/max_id_rsa.pub" do
    source "max_id_rsa.pub"
    owner node[:tow][:username]
    group node[:tow][:username]
    action :create_if_missing
end

cookbook_file "/home/#{node[:tow][:username]}/.ssh/unkot_id_rsa.pub" do
    source "unkot_id_rsa.pub"
    owner node[:tow][:username]
    group node[:tow][:username]
    action :create_if_missing
end

bash "preparing ssh for #{node[:tow][:username]} user" do
    user node[:tow][:username]
    cwd "/home/#{node[:tow][:username]}"
    code <<-EOM
        touch .bashrc
        touch .ssh/authorized_keys
        echo "sudo chown #{node[:tow][:username]} $SSH_TTY" >> .bashrc
        cat .ssh/max_id_rsa.pub >> .ssh/authorized_keys
        cat .ssh/unkot_id_rsa.pub >> .ssh/authorized_keys
    EOM
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

package "screen" do
end

package "ruby" do
end

package "rubygems" do
end

execute "gem install rake" do
end

execute "gem install bundler" do
end

bash "creating screen for #{node[:tow][:username]} user" do
    user node[:tow][:username]
    code <<-EOM
        screen -r #{node[:tow][:username]} -X quit
        screen -d -m -S #{node[:tow][:username]} -t #{node[:tow][:username]} && screen -r #{node[:tow][:username]} -X hardstatus alwayslastline "%-Lw%{= BW}%50>%n%f* %t%{-}%+Lw%< %= %H"
    EOM
end

execute "sudo usermod -a -G sudo #{node[:tow][:username]}" do
end

execute "sudo usermod -a -G admin #{node[:tow][:username]}" do
end


#
# Cookbook Name:: wheel
# Recipe:: default
#

case node[:platform]
when "ubuntu", "debian"
    execute "apt-get update" do
        ignore_failure true
        action :run
    end
end

include_recipe "wheel::rabbitmq"
include_recipe "wheel::cassandra"
include_recipe "wheel::api"
include_recipe "wheel::worker"


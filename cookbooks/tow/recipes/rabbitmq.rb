#
# Cookbook Name:: wheel
# Recipe:: rabbitmq
#

package "rabbitmq-server" do
    action :install
end

execute "download rabbitmq-server" do
    command "wget http://www.rabbitmq.com/releases/rabbitmq-server/v2.8.2/rabbitmq-server_2.8.2-1_all.deb" 
    cwd "/tmp"
end

execute "install rabbitmq-server" do
    command "dpkg -i rabbitmq-server_2.8.2-1_all.deb"
    cwd "/tmp"
end

execute "stop rabbitmq-server" do
    command "/etc/init.d/rabbitmq-server stop"
end

execute "rm erlang.cookie" do
    command "rm /var/lib/rabbitmq/.erlang.cookie"
end

execute "rf -rf mnesia" do
    command "rm -rf /var/lib/rabbitmq/mnesia"
end

cookbook_file "/var/lib/rabbitmq/.erlang.cookie" do
    source "erlang.cookie"
    owner "rabbitmq"
    group "rabbitmq"
    mode "0400"
    action :create_if_missing
end

execute "start rabbitmq-server" do
    command "/etc/init.d/rabbitmq-server start"
end

execute "rabbitmq stop_app && reset" do
    command "rabbitmqctl stop_app && rabbitmqctl reset"
end

execute "rabbitmq start_app" do
    command "rabbitmqctl start_app"
end

execute "rabbitmq change_password" do
    command "rabbitmqctl change_password guest #{node[:stack][:rabbit][:password]}"
end
#todo: use search
#execute "add os-main to hosts" do
#    command "echo \"\r\n10.0.0.101     os-main\n\r10.0.0.102    os-rabbit\" >> /etc/hosts"
#end

#execute "rabbitmq cluster rabbit@os-main rabbit@os-rabbit"

#execute "rabbitmqctl change_password guest #{node[:stack][:rabbit][:password]}" do
#end

#execute "rabbitmqctl start_app"


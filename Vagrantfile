# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.define :tow do |towall|
        towall.vm.network :hostonly, "10.100.0.101", :netmask => "255.255.0.0"
        towall.vm.host_name = "tow-all"
        towall.vm.box = "precise64"
        towall.vm.forward_port 22, 2232
        towall.vm.forward_port 80, 8081
        towall.vm.forward_port 8080, 8082
        towall.vm.provision :chef_solo do |chef|
            chef.cookbooks_path = "cookbooks"
            chef.add_recipe "tow::rabbitmq"
            chef.add_recipe "tow::cassandra"
            chef.add_recipe "tow::api"
            chef.add_recipe "tow::worker"
            chef.log_level = :debug
        end
        towall.vm.customize [
            "modifyvm", :id,
            "--name", "Tow AllInOne",
            "--memory", "1024",
            "--natdnshostresolver1", "on"
        ]
    end
end


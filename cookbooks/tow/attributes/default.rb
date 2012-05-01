default[:wheel][:username] = "wheeel"
default[:stack][:repository_url] = "https://github.com/OpenStack-Kha/devstack.git"
default[:stack][:branch] = "stable-essex3"
default[:stack][:mysql][:host] = "127.0.0.1"
default[:stack][:mysql][:user] = "root"
default[:stack][:mysql][:password] = "nova"
default[:stack][:rabbit][:host] = "127.0.0.1"
default[:stack][:rabbit][:password] = "nova"
default[:stack][:libvirt_type] = "qemu"
default[:stack][:enabled_services] = "g-api,g-reg,key,n-api,n-crt,n-obj,n-cpu,n-net,n-sch,n-novnc,n-xvnc,n-cauth,horizon,mysql,rabbit,n-vol"
default[:stack][:repos] = {
                            "KEYSTONE" => "https://github.com/OpenStack-Kha/keystone.git",
                            "NOVA" => "https://github.com/OpenStack-Kha/nova.git",
                            "SWIFT" => "https://github.com/OpenStack-Kha/swift.git",
                            "SWIFT_KEYSTONE" => "https://github.com/OpenStack-Kha/swift-keystone2.git",
                            "GLANCE" => "https://github.com/OpenStack-Kha/glance.git",
                            "NOVNC" => "https://github.com/OpenStack-Kha/noVNC.git",
                            "HORIZON" => "https://github.com/OpenStack-Kha/horizon.git",
                            "NOVACLIENT" => "https://github.com/OpenStack-Kha/python-novaclient.git",
                            "KEYSTONECLIENT" => "https://github.com/OpenStack-Kha/python-keystoneclient.git",
                            "QUANTUM" => "https://github.com/OpenStack-Kha/quantum.git",
                            "QUANTUM_CLIENT" => "https://github.com/OpenStack-Kha/python-quantumclient.git",
                            "TEMPEST" => "https://github.com/openstack/tempest.git",
                            "MELANGE" => "https://github.com/OpenStack-Kha/melange.git",
                            "MELANGECLIENT" => "https://github.com/OpenStack-Kha/python-melangeclient.git"
                            }
default[:stack][:branches] = {
                            "KEYSTONE" => "stable-essex3",
                            "NOVA" => "stable-essex3",
                            "SWIFT" => "stable-essex3",
                            "SWIFT_KEYSTONE" => "stable-essex3",
                            "GLANCE" => "stable-essex3",
                            "NOVNC" => "stable-essex3",
                            "HORIZON" => "stable-essex3",
                            "NOVACLIENT" => "stable-essex3",
                            "KEYSTONECLIENT" => "stable-essex3",
                            "QUANTUM" => "stable-essex3",
                            "QUANTUM_CLIENT" => "stable-essex3",
                            "TEMPEST" => "master",
                            "MELANGE" => "stable-essex3",
                            "MELANGECLIENT" => "stable-essex3"
                            }



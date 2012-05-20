TOW
===

Service responsible for all backend operations of yacht email client.

Installation instructions
-------------------------

1. [install vagrant](http://downloads.vagrantup.com/)

2. add vagrant box

    vagrant box add precise64 http://files.vagrantup.com/precise64.box

3. run tow

    vagrant up
    ssh tow@localhost -p 2232
    screen -r

Architecture
------------

    HTTP (JSON)
     |
     |
    [LB]
     |                   ---------
      ----[API node]---> |Message|
     |                   |  BUS  |
      ----[API node]---> |       |
                         ---------
                          |
                          |
                           -----[Worker node]
                          |
                           -----[Worker node]

* LoadBalancer - any free software load balancer, e.g. HAProxy.
* API node - Ruby backend on top of Sinatra.
* Message Bus - RabbitMQ.
* Worker node - simple process to do a job written in Ruby.


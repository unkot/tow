TOW
===

Service responsible for all backend operations of yacht email client.


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

LoadBalancer - any free software load balancer, e.g. HAProxy.
API node - Ruby backend on top of Sinatra.
Message Bus - RabbitMQ.
Worker node - simple process to do a job written in Ruby.


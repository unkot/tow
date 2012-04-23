# vim: filetype=ruby
# vim: tabstop=2 expandtab
# encoding: utf-8
# 
# tow_server.rb
# 
# Contains API calls bindings

require "rubygems"
require "amqp"
require 'sinatra'
require 'redis'

get '/' do
  'Tow API server version 0.1'
end

post '/authenticate' do
  '
  {
    "token": "abc123"
  }
  '
end

def new_id
  id = UUIDTools::UUID.sha1_create(UUIDTools::UUID_DNS_NAMESPACE, "tow.codemire.com")
  return id
end

get '/labels' do
  job_id = new_id

  r = Redis.new
  r.multi do
    while (true) do
      if r.exists? job_id
        job_id = new_id 
      else
        r[job_id] = '"created":timestamp\n'
        break
      end
    end
  end

  EventMachine.run do
    connection = AMQP.connect(:host => '127.0.0.1')
    puts "Connected to AMQP broker. Running #{AMQP::VERSION} version of the gem..."

    channel  = AMQP::Channel.new(connection)
    queue    = channel.queue("codemire.tow.label_list", :auto_delete => true)
    exchange = channel.direct("")

    exchange.publish "Hello, world!", :routing_key => queue.name
    connection.close { EventMachine.stop }
  end
  '{"job": "#{job_id}"}'
end

get '/label' do
  email_id = params['email']
end

put '/label' do
  email_id = params['email']
end

delete '/label' do
  email_id = params['email']
end

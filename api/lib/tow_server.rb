# vim: filetype=ruby
# vim: tabstop=2 expandtab
# encoding: utf-8
# 
# tow_server.rb
# 
# Contains API calls bindings

require "rubygems"
require "sinatra"
require "cassandra"

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

get '/labels' do
  user = "ivan"
  password = "petrov"
  job_type = "label_list"
  job = Job.new(:job_type => job_type, :user => user, :password => password)
  SubmitJob.submit(job)
  "{'job': '#{job.key}'}"
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

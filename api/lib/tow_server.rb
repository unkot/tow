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

get '/results' do
  user = "ivan"
  password = "petrov"
  key = params['key']
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
  user = "ivan"
  password = "petrov"
  job_type = "label_get"
  job = ProcessEmailJob.new(:job_type => job_type, :user => user, :password => password, :email_id => email_id)
  SubmitJob.submit(job)
  "{'job': '#{job.key}'}"
end

put '/label' do
  email_id = params['email']
  value = params['value']
  user = "ivan"
  password = "petrov"
  job_type = "label_add"
  job = ProcessEmailJob.new(:job_type => job_type, :user => user, :password => password,
                            :email_id => email_id, :value => value)
  SubmitJob.submit(job)
  "{'job': '#{job.key}'}"
end

delete '/label' do
  email_id = params['email']
  user = "ivan"
  password = "petrov"
  job_type = "label_delete"
  job = ProcessEmailJob.new(:job_type => job_type, :user => user, :password => password,
                            :email_id => email_id, :value => value)
  SubmitJob.submit(job)
  "{'job': '#{job.key}'}"
end

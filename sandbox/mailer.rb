# encoding: utf-8
require "sinatra"
require "net/imap"
require "net/smtp"
require "gmail"
require "openssl"

configure do
	set :username, 'user@gmail.com'
	set :password, 'secret'
	set :default_encoding, 'utf-8'
end

get '/' do
	'Hi! This is Tow! :)'
end

get '/labels' do
	labels = Array.new
	Gmail.new(settings.username, settings.password) do |gmail|
		gmail.labels.each do |label|
			labels << label.force_encoding('utf-8')
		end
	end
	erb :labels_json, :locals => {:labels => labels}
end

get '/mail' do
	mail = Array.new
	Gmail.new(settings.username, settings.password) do |gmail|
		#gmail.peek = true
		gmail.inbox.emails(:after => Date.parse("2012-05-17")).each do |email|
			email.body.parts.each do |part|
				mail << part
			end
		end
	end
	erb :labels, :locals => {:labels => mail}
end
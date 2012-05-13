# vim: filetype=ruby
# vim: tabstop=2 expandtab
# encoding: utf-8
#
# tow_server.rb
#
# Retrieves Label List

class ReceiveLabelList
  def run(job)
    labels = Array.new
    user = job[:user]
    password = job[:password]
    Gmail.new(user, password) do |gmail|
      gmail.labels.each do |label|
        labels << label
      end
    end
    labels
  end
end
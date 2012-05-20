module Screen
  def screen_it(user, screenName, cmd)
    bash "screen for #{screenName}" do
      user user
      code <<-EOM
        screen -S #{user} -X screen -t #{screenName}
        screen -S #{user} -p #{screenName} -X stuff '#{cmd}\n'
      EOM
    end
  end
end

class Chef::Recipe
  include Screen
end

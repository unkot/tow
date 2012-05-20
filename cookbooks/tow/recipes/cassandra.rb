#
# Cookbook Name:: tow
# Recipe:: cassandra
#

package "openjdk-7-jdk"

bash "installing cassandra repos and public keys" do
    code <<-EOM
    echo deb http://www.apache.org/dist/cassandra/debian/ 11x main >> /etc/apt/sources.list
    echo deb-src http://www.apache.org/dist/cassandra/debian/ 11x main >> /etc/apt/sources.list
    #This simply means you need to add the PUBLIC_KEY. You do that like this:
    gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
    gpg --export --armor F758CE318D77295D | sudo apt-key add -
    #Starting with the 0.7.5 debian package, you will also need to add public key 2B5C1B00 using the same commands as above:
    gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00
    gpg --export --armor 2B5C1B00 | sudo apt-key add -
    EOM
end

execute "install cassandra" do
    command "apt-get update && apt-get install -y cassandra"
end

execute "starting cassandra" do
    command "/etc/init.d/cassandra start"
end


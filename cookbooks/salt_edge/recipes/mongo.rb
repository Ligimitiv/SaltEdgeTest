# add mongo-db repo
execute 'gpg_add' do
  command 'curl -fsSL https://pgp.mongodb.com/server-4.4.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-4.4.gpg --dearmor'
end

file '/etc/apt/sources.list.d/mongodb-org-4.4.list' do
  content 'deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.4 multiverse'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# apt update after repo add
apt_update 'initial' do
  ignore_failure true
  action :update
end

# Mongo-DB install
apt_package 'mongodb-org' do
  action :install
end

# Start and Enable mongo-db service
systemd_unit 'mongod.service' do
  action [:enable, :start]
end
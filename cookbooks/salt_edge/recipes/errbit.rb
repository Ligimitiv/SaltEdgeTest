# Creating a user
user "errbit" do
  home "/home/errbit"
  shell "/bin/bash"
  password "$1$gPsnllgq$2C2VNndFAT07oyrx4i0Y2/"
  not_if "getent passwd errbit"
end

# creating directory for errbit repo
directory '/home/errbit/repo' do
  recursive true
end

# Downloading errbit repo
git "/home/errbit/repo" do
  repository "https://github.com/errbit/errbit.git"
  reference "main"
  action :sync
end

# Setting up variables file
file '/home/errbit/repo/.env' do
  content "ERRBIT_HOST=#{node['errbit']['host']}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


# Installation of errbit using bundler
execute "bundle-install" do
  cwd "/home/errbit/repo/"
  command "bundle install"
  action :run
end

execute "bundle-exec" do
  cwd "/home/errbit/repo/"
  command "bundle exec rake errbit:bootstrap"
  action :run
end

# Creating a systemd service for errbit 
file '/etc/systemd/system/errbit.service' do
  content "[Unit]\nDescription=errbit service\nAfter=network.target\n\n[Service]\nType=simple\nRestart=always\nRestartSec=1\nUser=root\nWorkingDirectory=/home/errbit/repo/\nExecStart=/usr/local/bin/bundle exec rails server -p #{node['errbit']['port']} -b #{node['errbit']['addr']}\nExecStop=/bin/kill -TSTP $MAINPID\n\n[Install]\nWantedBy=multi-user.target\n"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# systemd reload to get the new service
execute 'systemctl daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

# Start and Enable errbit service
systemd_unit 'errbit.service' do
  action [:enable, :start]
end

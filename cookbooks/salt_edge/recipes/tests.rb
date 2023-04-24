# I have decided to run all tests localy. 
# Therefore I have installed inspec localy and
# created a test file with tesing of the services for
# Mongo and Errbit, as well as testing of the port.
execute 'Inspec_install' do
    command "curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec"
    action :run
end

file '/home/errbit/service_test.rb' do
    content "describe service('mongod') do\n    it { should be_installed }\n    it { should be_enabled }\n    it { should be_running }\nend\n\ndescribe service('errbit.service') do\n    it { should be_enabled }\n    it { should be_running }\nend\n\ndescribe port('#{node['errbit']['addr']}', #{node['errbit']['port']}) do\n    it { should be_listening }\nend\n"
    owner 'errbit'
    group 'errbit'
    mode '0755'
    action :create
end

execute 'Inspec_run' do
    command 'inspec exec /home/errbit/service_test.rb'
    action :run
end
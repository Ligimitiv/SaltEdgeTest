# Dependency installation for Ruby 2.7.6
package ['g++', 'autoconf', 'bison', 'libffi-dev', 'libgdbm-dev', 'libncurses5-dev', 'libsqlite3-dev', 'libtool', 'libyaml-dev', 'make', 'pkg-config', 'sqlite3', 'zlib1g-dev', 'libgmp-dev', 'libreadline6-dev', 'libssl-dev'] do
    action :install
end

directory '/ruby' do
    recursive true
end

# Download source file
remote_file '/ruby/ruby-2.7.6.tar.gz' do
    source 'http://ftp.ruby-lang.org/pub/ruby/2.7/ruby-2.7.6.tar.gz'
    notifies :run, "bash[source_install]", :immediately
end

# Installation of ruby-2.7.6 from source
bash 'source_install' do
    user "root"
    cwd "/ruby/"
    live_stream false
    code <<-EOH
        tar -zxf ruby-2.7.6.tar.gz
        cd ruby-2.7.6/ && ./configure && make && make install
    EOH
    action :nothing
end

# Updating Bundle gem for errbit installation
gem_package 'bundler' do
    version '2.3.21'
    action :install
end

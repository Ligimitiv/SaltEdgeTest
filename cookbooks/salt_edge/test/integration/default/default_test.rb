# # encoding: utf-8

# Inspec test for recipe salt_edge::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('mongod') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
end

describe service('errbit.service') do
    it { should be_enabled }
    it { should be_running }
end

describe port(3000) do
    it { should be_listening }
end
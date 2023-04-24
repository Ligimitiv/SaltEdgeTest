current_dir = File.dirname(__FILE__)
log_level	:info
log_location 	STDOUT
node_name	'tony'
client_key	"tony.pem"
validation_client_name	'salt-validator'
validation_key 	"salt-validator.pem"
chef_server_url	'https://chef/organizations/salt'
cache_type	'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums")
cookbook_path	["#{current_dir}/../cookbooks"]

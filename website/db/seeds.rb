
puts 'create default_bastion_host'

default_bastion_host = Settings.default_bastion_host.to_h

bastion_host = BastionHost.find_or_initialize_by(ip: default_bastion_host[:ip])
bastion_host.attributes = default_bastion_host
bastion_host.save!



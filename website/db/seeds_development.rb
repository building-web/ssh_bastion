puts 'create bastion_hosts'
10.times do
  FactoryGirl.create :bastion_host
end

puts 'create hosts'
10.times do
  FactoryGirl.create :host
end

puts 'create host_users'
10.times do
  FactoryGirl.create :host_user
end

puts 'create accounts_ssh_keys'
10.times do
  FactoryGirl.create :accounts_ssh_key
end

puts 'create accounts_host_users'
10.times do
  FactoryGirl.create :accounts_host_user
end


puts 'create accounts_ssh_key'
10.times do
  FactoryGirl.create :accounts_ssh_key
end

puts 'create bastion_hosts'
10.times do
  FactoryGirl.create :bastion_host
end

puts 'create accounts_host_user'
10.times do
  FactoryGirl.create :accounts_host_user
end

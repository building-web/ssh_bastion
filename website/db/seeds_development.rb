puts 'create bastion_host'
10.times do
  FactoryGirl.create :bastion_host
end

puts 'create host'
10.times do
  FactoryGirl.create :host
end

puts 'create host_user'
10.times do
  FactoryGirl.create :host_user
end

puts 'create accounts_ssh_key'
10.times do
  FactoryGirl.create :accounts_ssh_key
end

puts 'create accounts_host_user'
10.times do
  FactoryGirl.create :accounts_host_user
end

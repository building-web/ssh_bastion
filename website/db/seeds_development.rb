puts 'create admins'

admins = []
admin_with_enabled_two_factors = []
3.times do
  admin = FactoryGirl.create :admin
  admins << admin

  admin_with_enabled_two_factor = FactoryGirl.create :admin_with_enabled_two_factor
  admin_with_enabled_two_factors << admin_with_enabled_two_factor
end

puts 'create users'
users = []
user_with_enabled_two_factors = []
10.times do
  user = FactoryGirl.create :user
  users << user

  user_with_enabled_two_factor = FactoryGirl.create :user_with_enabled_two_factor
  user_with_enabled_two_factors << user_with_enabled_two_factor
end

puts 'create account_ssh_keys'
admins.each do |account|
  FactoryGirl.create :account_ssh_key, account: account
end
users.each do |account|
  FactoryGirl.create :account_ssh_key, account: account
end

puts 'create host'
hosts = []
admin_with_enabled_two_factors.each do |account|
  host = FactoryGirl.create :host
  hosts << host
end

puts 'create assigned_hosts'
user_with_enabled_two_factors.each do |account|
  hosts.each do |host|
    FactoryGirl.create :assigned_host, account: account, host: host
  end
end

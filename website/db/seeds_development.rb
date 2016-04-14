puts 'create admins'

admins = []
3.times do
  admin = FactoryGirl.create :admin
  admins << admin

  admin_with_enabled_two_factor = FactoryGirl.create :admin_with_enabled_two_factor
  admins << admin_with_enabled_two_factor
end

puts 'create users'
users = []
10.times do
  user = FactoryGirl.create :user
  users << user

  user_with_enabled_two_factor = FactoryGirl.create :user_with_enabled_two_factor
  users << user_with_enabled_two_factor
end

puts 'create account_ssh_keys'
admins.each do |account|
  FactoryGirl.create :account_ssh_key, account: account
end
users.each do |account|
  FactoryGirl.create :account_ssh_key, account: account
end

puts 'create hosts and host_users'
host_users = []
admins.each do |account|
  host = FactoryGirl.create :host, creator_account: account
  host_user = FactoryGirl.create :host_user, host: host
  host_users << host_user
end

puts 'create accounts_host_users'
users.each do |account|
  host_users.each do |host_user|
    FactoryGirl.create :accounts_host_user, account: account, host: host_user.host, host_user: host_user
  end
end

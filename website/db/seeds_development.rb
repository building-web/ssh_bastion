puts 'create admins'
admins = []
3.times do
  admin = FactoryGirl.create :admin
  admins << admin
end

puts 'create users'
users = []
10.times do
  user = FactoryGirl.create :user
  users << user
end

puts 'create ssh_keys'
admins.each do |account|
  FactoryGirl.create :ssh_key, account: account
end
users.each do |account|
  FactoryGirl.create :ssh_key, account: account
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

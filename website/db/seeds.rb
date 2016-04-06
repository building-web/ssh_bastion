
puts 'create super_admin'
Account.find_or_create_by!(email: Settings.super_admin.email) do |account|
  account.password = SecureRandom.hex
  account.skip_confirmation!
end

puts 'create bastion_hosts'
case Settings.Arch_mode.to_i
when 1
  arch_mode = 1
  ip = '127.0.0.1'
  user = Settings.Arch_mode_one.user

  bastion_host = BastionHost.find_or_initialize_by(arch_mode: arch_mode, ip: ip)
  bastion_host.user = user
  bastion_host.save!
end

if Rails.env.development?
  require 'database_cleaner'
  require 'factory_girl_rails'
  require 'ffaker'

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  require Rails.root.join("db/seeds_development").to_s
end

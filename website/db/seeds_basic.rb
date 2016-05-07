puts 'create super_admin'
Account.find_or_create_by!(email: Settings.super_admin_email) do |account|
  account.password = SecureRandom.hex
  account.role = :admin
  account.skip_confirmation!
end

puts 'create default bastion_host'
BastionHost.build_default

puts 'create default host'
Host.build_default



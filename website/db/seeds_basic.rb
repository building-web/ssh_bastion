puts 'create super_admin'
Account.find_or_create_by!(email: Settings.super_admin.email) do |account|
  account.password = SecureRandom.hex
  account.role = :admin
  account.skip_confirmation!
end

puts 'create bastion_hosts'
BastionHost.build_default



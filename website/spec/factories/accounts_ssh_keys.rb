FactoryGirl.define do

  factory :accounts_ssh_key do
    association :account, factory: :user
    cat { ['dsa', 'ecdsa', 'ed25519', 'rsa', 'rsa1'].sample }
    content { SecureRandom.hex(186) }
    comment { FFaker::Lorem.sentence }
  end

end
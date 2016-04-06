FactoryGirl.define do

  factory :accounts_ssh_key do
    association :account, factory: :user, strategy: :build
    key_type { ['dsa', 'ecdsa', 'ed25519', 'rsa', 'rsa1'].sample }
    public_key { SecureRandom.hex(186) }
    comment { FFaker::Lorem.sentence }
  end

end
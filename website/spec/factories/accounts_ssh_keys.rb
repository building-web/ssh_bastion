FactoryGirl.define do
  sequence :key_type do
    ['dsa', 'ecdsa', 'ed25519', 'rsa', 'rsa1'].sample
  end

  factory :accounts_ssh_key do
    association :account, factory: :user, strategy: :build
    key_type { generate :key_type }
    public_key { SecureRandom.hex(186) }
    comment { FFaker::Lorem.sentence }
  end
end
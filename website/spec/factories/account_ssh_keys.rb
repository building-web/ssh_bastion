FactoryGirl.define do

  factory :account_ssh_key do
    association :account, factory: :user
    title { FFaker::Lorem.sentence }
    cat { 1 }
    content { SecureRandom.hex(186) }
    comment { '' }
  end

end

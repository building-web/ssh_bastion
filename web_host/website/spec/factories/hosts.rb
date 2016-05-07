FactoryGirl.define do

  factory :host do
    association :creator_account, factory: :admin

    ip { FFaker::InternetSE.ip_v4_address }
    port { 22 }

    code { SecureRandom.hex(4) }
    comment { FFaker::Lorem.sentence }

    user1 { 'deploy' }
    user2 { nil }
    user3 { nil }
  end

end

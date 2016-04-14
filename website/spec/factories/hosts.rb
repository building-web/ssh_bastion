FactoryGirl.define do

  factory :host do
    association :creator_account, factory: :admin

    ip { FFaker::InternetSE.ip_v4_address }
    port { 22 }

    code { SecureRandom.hex(4) }

    comment { FFaker::Lorem.sentence }

    user1 { FFaker::Internet.domain_name }
    user2 { FFaker::Internet.domain_name }
    user3 { FFaker::Internet.domain_name }
  end

end

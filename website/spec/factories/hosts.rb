FactoryGirl.define do

  factory :host do
    association :creator_account, factory: :admin

    ip { FFaker::InternetSE.ip_v4_address }
    code { SecureRandom.hex(4) }
    port { '22' }
    comment { FFaker::Lorem.sentence }
  end

end
FactoryGirl.define do
  factory :bastion_host do

    ip { FFaker::InternetSE.ip_v4_address }
    user { :developer }
    desc { '' }

  end
end
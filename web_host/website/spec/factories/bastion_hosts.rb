FactoryGirl.define do

  factory :bastion_host do
    ip { FFaker::InternetSE.ip_v4_address }
    port { 22 }

    user { :developer }
    desc { '' }
  end

end
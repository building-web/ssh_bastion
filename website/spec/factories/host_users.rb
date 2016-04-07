FactoryGirl.define do

  factory :host_user do
    association :host
    name { FFaker::Name.last_name }
  end

end
FactoryGirl.define do

  factory :assigned_host do
    association :account, factory: :user
    association :host
    mark { FFaker::Lorem.word }

    user1 { |record| record.host.user1 }
  end

end
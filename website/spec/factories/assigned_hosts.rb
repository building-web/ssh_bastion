FactoryGirl.define do

  factory :assigned_host do
    association :account, factory: :user
    association :host
    mark { FFaker::Lorem.word }

    user1 { |record| record.host.user1 }
    user2 { |record| record.host.user2 }
    user3 { |record| record.host.user3 }
  end

end
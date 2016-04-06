FactoryGirl.define do
  factory :accounts_host_user do
    association :account, factory: :user, strategy: :build
    association :bastion_host, strategy: :build
    host_user { FFaker::Name.last_name }
  end
end
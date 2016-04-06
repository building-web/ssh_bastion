FactoryGirl.define do
  factory :accounts_host_user do
    association :account, factory: :user
    association :host_user
    host_id { |record| record.host_user.host_id }
  end
end
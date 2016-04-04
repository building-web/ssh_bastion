FactoryGirl.define do
  factory :account do

    email { FFaker::Internet.email(SecureRandom.hex(3)) }
    password { 'password' }

    factory :user do
    end

    factory :admin do
    end

    after(:build) do |account|
      account.skip_confirmation!
    end
  end
end

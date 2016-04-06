FactoryGirl.define do

  sequence :account_email do |n|
    "user%s@example.com" % n
  end

  factory :account do

    email { generate :account_email }
    password { 'password' }
    role { 1 }

    factory :user do
      role { 1 }
      factory :user_with_enabled_two_factor do
      end
    end

    factory :admin do
      role { 9 }

      factory :admin_with_enabled_two_factor do
      end
    end

    after(:build) do |account|
      account.skip_confirmation!
    end
  end
end

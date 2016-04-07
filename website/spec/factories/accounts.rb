FactoryGirl.define do

  sequence :account_email do |n|
    "user%s@example.com" % n
  end

  factory :account do

    email { generate :account_email }
    password { 'password' }
    role { :user }

    factory :user do
      role { :user }
      factory :user_with_enabled_two_factor do
      end
    end

    factory :admin do
      role { :admin }

      factory :admin_with_enabled_two_factor do
      end
    end

    after(:build) do |account|
      account.skip_confirmation!
    end
  end
end

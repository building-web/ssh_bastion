FactoryGirl.define do

  sequence :user_email do |n|
    "user%s@example.com" % n
  end

  sequence :admin_email do |n|
    "admin%s@example.com" % n
  end

  factory :account do

    email { generate :user_email }
    password { 'password' }
    role { :user }

    factory :user do
      role { :user }
      factory :user_with_enabled_two_factor do
        otp_secret { '123456' }
        consumed_timestep { 48669715 }
        otp_required_for_login { false }
      end
    end

    factory :admin do
      role { :admin }
      email { generate :admin_email }

      factory :admin_with_enabled_two_factor do
        otp_secret { '123456' }
        consumed_timestep { 48669715 }
        otp_required_for_login { false }
      end
    end

    after(:build) do |account|
      account.skip_confirmation!
    end
  end
end

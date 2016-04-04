FactoryGirl.define do
  factory :user do

    email { FFaker::Internet.email(SecureRandom.hex(3)) }
    password { 'password' }

  end
end
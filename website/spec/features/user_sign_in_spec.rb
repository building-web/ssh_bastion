require 'rails_helper'

RSpec.feature "UserSignIn", type: :feature do

  background do
    @user = create :user, email: 'test@example.com', password: 'password'
  end

  scenario 'user enter right account' do
    sign_in_user_with @user.email, 'password'
    user_sees_flash_notice 'Welcome, person@example.com'
  end

  scenario 'user enter wrong account' do
    sign_in_user_with @user.email, 'wrong password'
    user_sees_flash_alert 'Invalid email or password'
  end

end

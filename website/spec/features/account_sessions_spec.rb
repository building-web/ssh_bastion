require 'rails_helper'

RSpec.feature "AccountSessions", type: :feature do

  background do
    @admin = create :admin, password: 'password'

    @user = create :user, password: 'password'
  end

  scenario 'admin enter right account' do
    sign_in_admin_with @admin.email, 'password'

    expect(page).to have_current_path('/account')
    admin_sees_flash_notice 'Signed in successfully'
  end

  scenario 'admin enter wrong account' do
    sign_in_admin_with @admin.email, 'wrong password'

    expect(page).to have_current_path('/accounts/sign_in')
    admin_sees_flash_alert 'Invalid email or password'
  end

  scenario 'user enter right account' do
    sign_in_user_with @user.email, 'password'

    expect(page).to have_current_path('/account')
    user_sees_flash_notice 'Signed in successfully'
  end

  scenario 'user enter wrong account' do
    sign_in_user_with @user.email, 'wrong password'

    expect(page).to have_current_path('/accounts/sign_in')
    user_sees_flash_alert 'Invalid email or password'
  end

end

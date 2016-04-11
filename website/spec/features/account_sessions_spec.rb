require 'rails_helper'

RSpec.feature "AccountSessions", type: :feature do

  background do
    @user = create :user, password: 'password'
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

  scenario 'user sign_out' do
    sign_in_user_with @user.email, 'password'

    expect(page).to have_selector "a[href='/accounts/sign_out']"

    find("a[href='/accounts/sign_out']").click

    expect(page).to have_current_path('/')
  end

end

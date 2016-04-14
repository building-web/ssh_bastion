require 'rails_helper'

RSpec.feature "Account::Sessions", type: :feature do

  background do
    @user = create :user, password: 'password'
  end

  scenario 'user enter right account' do
    visit new_account_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_current_path('/account')
    user_sees_flash_notice 'Signed in successfully'
  end

  scenario 'user enter wrong account' do
    visit new_account_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'wrong password'
    click_button 'Sign in'

    expect(page).to have_current_path('/accounts/sign_in')
    user_sees_flash_alert 'Invalid email or password'
  end

  scenario 'user sign_out' do
    visit new_account_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_selector "a[href='/accounts/sign_out']"

    find("a[href='/accounts/sign_out']").click

    expect(page).to have_current_path('/')
  end

end

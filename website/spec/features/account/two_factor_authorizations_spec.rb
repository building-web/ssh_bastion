require 'rails_helper'

RSpec.feature "Account::TwoFactorAuthorization", type: :feature do
  background do

    @user1 = create :user
    @user2 = create :user_with_enabled_two_factor

  end

  scenario "the 'Two-factor authentication' sidebar should active" do
    switch_user @user1

    visit '/account/two_factor_authentication'

    expect(page).to have_selector "a.active[href='/account/two_factor_authentication']"
    expect(page).to have_content 'Off'
  end

  scenario "user1 show list" do
    switch_user @user1

    visit '/account/two_factor_authentication'

    expect(page).to have_selector "a[href='/account/two_factor_authentication/new']"
  end

  scenario "user2 show list" do
    switch_user @user2

    visit '/account/two_factor_authentication'

    expect(page).to have_content 'On'
    expect(page).to have_selector "a[href='/account/two_factor_authentication/recovery_codes']", text: 'Download recovery codes'
    expect(page).to have_selector "a[href='/account/two_factor_authentication/reset']", text: 'Reset with recovery codes'
  end

  scenario "user1 scan qr code and then get digit code" do
    switch_user @user1

    visit '/account/two_factor_authentication/new'

    expect(page).to have_selector "img[alt='authentication device code']"
    expect(page).to have_content 'After scanning the barcode image, the app will display a six-digit code that you can enter below.'
    expect(page).to have_content 'Enter the six-digit code from the application'
    expect(page).to have_selector "a[href='https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2']"
    expect(page).to have_selector "a[href='https://play.google.com/store/apps/details?id=com.duosecurity.duomobile']"


    @user1.reload
    within("form#edit_account_#{@user1.id}") do
      fill_in 'Otp attempt', with: @user1.current_otp

      click_button 'Enable two-factor authentication'
    end

    expect(page).to have_current_path('/account/two_factor_authentication')
    user_sees_flash_notice 'Two-factor authentication was successfully created.'
  end

  scenario "user1 scan qr code and then get failed digit code" do
    switch_user @user1

    visit '/account/two_factor_authentication/new'

    expect(page).to have_selector "img[alt='authentication device code']"
    expect(page).to have_content 'After scanning the barcode image, the app will display a six-digit code that you can enter below.'
    expect(page).to have_content 'Enter the six-digit code from the application'

    @user1.reload
    within("form#edit_account_#{@user1.id}") do
      fill_in 'Otp attempt', with: '123457'

      click_button 'Enable two-factor authentication'
    end
    expect(page).to have_content 'Otp attempt is not match, please input agian'
  end
end
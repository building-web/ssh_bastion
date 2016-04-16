require 'rails_helper'

RSpec.feature "Account::TwoFactorAuthorization", type: :feature do
  background do

    @user1 = create :user
    @user2 = create :user_with_enabled_two_factor

  end

  scenario "the 'Two-factor authorization' sidebar should active" do
    switch_user @user1

    visit '/account/two_factor_authorization'

    expect(page).to have_selector "a.active[href='/account/two_factor_authorization']"
  end

  scenario "user1 show list" do
    switch_user @user1

    visit '/account/two_factor_authorization'

    expect(page).to have_selector "a.herf['/account/two_factor_authorization/new']"
  end

  scenario "user2 show list" do
    switch_user @user2

    visit '/account/two_factor_authorization'

    expect(page).to have_contet "Actived"
    expect(page).to have_selector "a.href['/account/two_factor_authorization/reset']"
    expect(page).to have_selector "a.href['/account/two_factor_authorization/recovery-codes.txt']", text: 'Download recovery codes'
  end

  scenario "user1 scan qr code and then get digit code" do
    switch_user @user1

    visit '/account/two_factor_authorization/new'

    expect(page).to have_selector "img[alt='authorization device code']"
    expect(page).to have_content "After scanning the barcode image, the app will display a six-digit code that you can enter below."
    expect(page).to have_content "Enter the six-digit code from the application"

    within('form#new_two_factor') do
      fill_in 'Otp Attempt', with: @user1.current_otp

      click_button 'Enable two-factor authentication'
    end

    expect(page).to have_current_path('/account/two_factor_authorization')
    user_sees_flash_notice 'Two-factor authentication was successfully actived.'
  end

  scenario 'user2 reset two-factor authorization' do
    switch_user @user2

    visit '/account/two_factor_authorization/reset'

    expect(page).to have_selector "img[alt='authorization device code']"
    expect(page).to have_content "After scanning the barcode image, the app will display a six-digit code that you can enter below."
    expect(page).to have_content "Enter the six-digit code from the application"

    within('form#new_two_factor') do
      fill_in 'Otp Attempt', with: @user1.current_otp

      click_button 'Enable two-factor authentication'
    end

    expect(page).to have_current_path('/account/two_factor_authorization')
    user_sees_flash_notice 'Two-factor authentication was successfully reset.'
  end

  scenario 'user2 disabled two-factor authorization' do
    switch_user @user2

    visit '/account/two_factor_authorization'

    find("a[href='/account/two_factor_authorization']").click

    accept_confirm

    expect(page).to have_current_path('/account/two_factor_authorization')
    user_sees_flash_notice 'Two-factor authorization was successfully canceled.'
    expect(page).to_not have_selector "a.herf['/account/two_factor_authorization/new']"
  end
end
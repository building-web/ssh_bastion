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
  end

  scenario "user1 show list" do
    switch_user @user1

    visit '/account/two_factor_authentication'

    expect(page).to have_selector "a[href='/account/two_factor_authentication/new']"
  end

  scenario "user2 show list" do
    switch_user @user2

    visit '/account/two_factor_authentication'

    expect(page).to have_content "Actived"
    expect(page).to have_selector "a[href='/account/two_factor_authentication/reset']"
    expect(page).to have_selector "a[href='/account/two_factor_authentication/recovery_codes']", text: 'Download recovery codes'
    expect(page).to have_selector "a[href='/account/two_factor_authentication']", text: 'Disable'
  end

  scenario "user1 scan qr code and then get digit code" do
    switch_user @user1

    visit '/account/two_factor_authentication/new'

    expect(page).to have_selector "img[alt='authentication device code']"
    expect(page).to have_content "After scanning the barcode image, the app will display a six-digit code that you can enter below."
    expect(page).to have_content "Enter the six-digit code from the application"

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
    expect(page).to have_content "After scanning the barcode image, the app will display a six-digit code that you can enter below."
    expect(page).to have_content "Enter the six-digit code from the application"

    @user1.reload
    within("form#edit_account_#{@user1.id}") do
      fill_in 'Otp attempt', with: '123457'

      click_button 'Enable two-factor authentication'
    end
    expect(page).to have_content 'is invalid'
  end

  scenario 'user2 reset two-factor authentication' do
    switch_user @user2

    visit '/account/two_factor_authentication/reset'

    expect(page).to have_selector "img[alt='authentication device code']"
    expect(page).to have_content "After scanning the barcode image, the app will display a six-digit code that you can enter below."
    expect(page).to have_content "Enter the six-digit code from the application"

    @user2.reload
    within("form#edit_account_#{@user2.id}") do
      fill_in 'Otp attempt', with: @user2.current_otp

      click_button 'Enable two-factor authentication'
    end

    expect(page).to have_current_path('/account/two_factor_authentication')
    user_sees_flash_notice 'Two-factor authentication was successfully created.'
  end

  scenario 'user2 reset two-factor authentication with error digit code' do
    switch_user @user2

    visit '/account/two_factor_authentication/reset'

    expect(page).to have_selector "img[alt='authentication device code']"
    expect(page).to have_content "After scanning the barcode image, the app will display a six-digit code that you can enter below."
    expect(page).to have_content "Enter the six-digit code from the application"

    @user2.reload
    within("form#edit_account_#{@user2.id}") do
      fill_in 'Otp attempt', with: '1234'

      click_button 'Enable two-factor authentication'
    end

    expect(page).to have_content 'is invalid'
  end

  scenario 'user2 disabled two-factor authentication' do
    switch_user @user2

    visit '/account/two_factor_authentication'

    find("[data-confirm='Are you sure to disable?']").click

    accept_confirm

    expect(page).to have_current_path('/account/two_factor_authentication/')
    user_sees_flash_notice 'Two-factor authentication was successfully destroyed.'
    expect(page).to have_selector "a.href['/account/two_factor_authentication/new']"
  end
end
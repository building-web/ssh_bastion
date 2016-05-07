require 'rails_helper'

RSpec.feature "Account::Accounts", type: :feature do

  background do

    @admin1 = create :admin_with_enabled_two_factor
    @admin1_ssh_public_key = generate_ssh_public_key('RSA', 'admin1@example.com')

    @admin2 = create :admin_with_enabled_two_factor
    @admin2_ssh_public_key = generate_ssh_public_key('RSA', 'admin2@example.com')

  end

  scenario "the 'Accounts' sidebar should active" do
    switch_user @admin1

    visit '/account/accounts'

    expect(page).to have_selector "a.active[href='/account/accounts']"
  end

  scenario 'admin1 show accounts list' do
    switch_user @admin1

    visit '/account/accounts'

    expect(page).to have_content @admin1.role_text
    expect(page).to have_content @admin1.email
  end

  scenario 'admin1 add a new admin', js: true do
    switch_user @admin1

    visit '/account/accounts/new'

    expect(page).to have_selector "form#new_account[action='/account/accounts']"

    within('form#new_account') do
      fill_in 'Email', with: 'test1@example.com'
      select 'Admin', from: 'account[role]'

      click_button 'Create Account'
    end

    expect(page).to have_current_path('/account/accounts')
    user_sees_flash_notice 'Account was successfully created.'

    expect(page).to have_content 'test1@example.com'
    expect(page).to have_content 'admin'
  end

  scenario 'admin1 add a new user', js: true do
    switch_user @admin1

    visit '/account/accounts/new'

    expect(page).to have_selector "form#new_account[action='/account/accounts']"

    within('form#new_account') do
      fill_in 'Email', with: 'test1@example.com'
      select 'User', from: 'account[role]'
      click_button 'Create Account'
    end

    expect(page).to have_current_path('/account/accounts')
    user_sees_flash_notice 'Account was successfully created.'

    expect(page).to have_content 'test1@example.com'
    expect(page).to have_content 'User'
  end

  scenario 'user2 add a invalid email that email is exists', js: true do
    switch_user @admin1

    visit '/account/accounts/new'

    expect(page).to have_selector "form#new_account[action='/account/accounts']"

    within('form#new_account') do
      fill_in 'Email', with: @admin1.email
      select 'User', from: 'account[role]'
      click_button 'Create Account'
    end

    expect(page).to have_current_path('/account/accounts')
    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'user2 delete a old account', js: true do
    switch_user @admin1

    visit '/account/accounts'

    expect(page).to have_selector "a[href='/account/accounts/#{@admin2.id}']", text: 'Delete'

    find("a[href='/account/accounts/#{@admin2.id}']").click

    accept_confirm

    expect(page).to have_current_path('/account/accounts')
    user_sees_flash_notice 'Account was successfully destroyed.'

    expect(page).to_not have_selector "a[href='/account/accounts/#{@admin2.id}']"
  end

end

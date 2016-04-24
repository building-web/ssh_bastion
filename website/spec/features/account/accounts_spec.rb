require 'rails_helper'

RSpec.feature "Account::Accounts", type: :feature do

  background do

    @admin1 = create :admin
    @admin1_ssh_public_key = generate_ssh_public_key('RSA', 'admin1@example.com')

  end

  scenario "the 'Accounts' sidebar should active" do
    switch_user @admin1

    visit '/account/accounts'

    expect(page).to have_selector "a.active[href='/account/accounts']"
  end

  scenario 'user1 show accounts list' do
    switch_user @admin1

    visit '/account/accounts'

    expect(page).to have_content @user1.name
    expect(page).to have_content @user1.email
  end

  scenario 'user1 add a new admin', js: true do
    switch_user @admin1

    visit '/account/accounts/new'

    expect(page).to have_selector "a[href='account/accounts/new']"

    expect(page).to have_selector "form#new_account_account[action='/account/account']"

    within('form#new_account_account') do
      fill_in 'Email', with: 'test1@example.com'
      select 'admin', from: 'Roles'

      click_button 'Add Account'
    end

    expect(page).to have_current_path('/account/accounts')
    user_sees_flash_notice 'Account was successfully created.'

    expect(page).to have_content 'test1@example.com'
    expect(page).to have_content 'admin'
  end

  scenario 'user1 add a new user', js: true do
    switch_user @admin1

    visit '/account/accounts/new'

    expect(page).to have_selector "a[href='account/accounts/new']"

    expect(page).to have_selector "form#new_account_account[action='/account/account']"

    within('form#new_account_account') do
      fill_in 'Email', with: 'test1@example.com'
      select 'user', from: 'Roles'
      click_button 'Add Account'
    end

    expect(page).to have_current_path('/account/accounts')
    user_sees_flash_notice 'Account was successfully created.'

    expect(page).to have_content 'test1@example.com'
    expect(page).to have_content 'user'
  end

  scenario 'user2 add a invalid email that email is exists', js: true do
        switch_user @admin1

    visit '/account/accounts/new'

    expect(page).to have_selector "a[href='account/accounts/new']"

    expect(page).to have_selector "form#new_account_account[action='/account/account']"

    within('form#new_account_account') do
      fill_in 'Email', with: @admin1.eamil
      select 'user', from: 'Roles'
      click_button 'Add Account'
    end

    expect(page).to have_current_path('/account/accounts')
    user_sees_flash_notice 'is exist'
  end

  scenario 'user2 delete a old account', js: true do
    switch_user @admin1

    visit '/account/accounts'

    expect(page).to have_selector "a[href='/account/accounts/#{@user1.id}']", text: 'Delete'

    find("a[href='/account/accounts/#{@user1.id}']").click

    accept_confirm

    expect(page).to have_current_path('/account/accounts')
    user_sees_flash_notice 'Account was successfully destroyed.'

    expect(page).to_not have_selector "a[href='/account/accounts/#{@user1.id}']"
  end

end

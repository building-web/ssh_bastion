require 'rails_helper'

RSpec.feature "Account::Hosts", type: :feature do

  background do
    @user = create :user_with_enabled_two_factor
    create :account_ssh_key, account: @user

    @admin1 = create :admin_with_enabled_two_factor
    create :account_ssh_key, account: @admin1

    @admin2 = create :admin_with_enabled_two_factor
    create :account_ssh_key, account: @admin2
    @admin_host2 = create :host, creator_account: @admin2
  end

  scenario "the 'Hosts' sidebar should active" do
    switch_user @user

    visit '/account/hosts'

    expect(page).to have_selector "a.active[href='/account/hosts']"
  end


  scenario "user cannot see new host button" do
    switch_user @user

    visit '/account/hosts'

    expect(page).to_not have_selector "a[href='/account/hosts/new']"
    expect(page).to have_selector "a.disabled[href='javascript:void(0);']", text: 'New Host'
  end

  scenario "admin1 can see new host button" do
    switch_user @admin1

    visit '/account/hosts'

    expect(page).to have_selector "a[href='/account/hosts/new']", text: 'New Host'
  end

  scenario 'admin1 show list' do
    switch_user @admin1

    visit '/account/hosts'

    expect(page).to have_content 'There are no hosts avaliable to your account.'
  end

  scenario 'admin2 show list' do
    switch_user @admin2

    visit '/account/hosts'

    expect(page).to have_content @admin_host2.ip
    expect(page).to have_content @admin_host2.port
    expect(page).to have_content @admin_host2.comment

    expect(page).to have_selector "a[href='/account/hosts/#{@admin_host2.id}/edit']", text: 'Edit'
    expect(page).to have_selector "a[data-method='delete'][href='/account/hosts/#{@admin_host2.id}']", text: 'Delete'
  end

  scenario 'admin1 add a new Host', js: true do
    switch_user @admin1

    visit '/account/hosts/new'

    expect(page).to have_selector "form#new_host[action='/account/hosts']"

    expect(page).to have_content "Users should not is 'root', User must have less than one value"

    within('form#new_host') do
      fill_in 'IP', with: '8.8.8.8'
      fill_in 'Port', with: 22
      fill_in 'Comment', with: 'host_comment'

      fill_in 'host[host_users_attributes][0][name]', with: 'dev'
      fill_in 'host[host_users_attributes][1][name]', with: 'app'

      click_button 'Add Host'
    end

    expect(page).to have_current_path('/account/hosts')
    user_sees_flash_notice 'Host was successfully created.'

    expect(page).to have_content '8.8.8.8'
    expect(page).to have_content '22'
    expect(page).to have_content 'host_comment'
  end

  scenario 'admin2 add a new Host that IP is exist', js: true do
    switch_user @admin2

    visit '/account/hosts/new'

    expect(page).to have_selector "form#new_host[action='/account/hosts']"

    within('form#new_host') do
      fill_in 'IP', with: @admin_host2.ip
      fill_in 'Port', with: '22'
      fill_in 'Comment', with: 'host_comment'

      fill_in 'host[host_users_attributes][0][name]', with: 'dev'

      click_button 'Add Host'
    end

    expect(page).to have_current_path('/account/hosts')
    expect(page).to have_content 'has already been taken'
  end

  scenario 'admin2 add a new Host that IP is invalid', js: true do
    switch_user @admin2

    visit '/account/hosts/new'

    expect(page).to have_selector "form#new_host[action='/account/hosts']"

    within('form#new_host') do
      fill_in 'IP', with: '0.0'
      fill_in 'Port', with: '22'
      fill_in 'Comment', with: 'host_comment'

      fill_in 'host[host_users_attributes][0][name]', with: 'dev'

      click_button 'Add Host'
    end

    expect(page).to have_current_path('/account/hosts')
    expect(page).to have_content 'is invalid'
  end

  scenario 'admin2 add a new Host that User is root', js: true do
    switch_user @admin2

    visit '/account/hosts/new'

    expect(page).to have_selector "form#new_host[action='/account/hosts']"

    within('form#new_host') do
      fill_in 'IP', with: '1.1.1.1'
      fill_in 'Port', with: '22'
      fill_in 'Comment', with: 'host_comment'

      fill_in 'host[host_users_attributes][0][name]', with: 'root'

      click_button 'Add Host'
    end

    expect(page).to have_current_path('/account/hosts')
    expect(page).to have_content "can not be same as 'root'"
  end

  scenario 'admin2 add a new Host that Users same', js: true do
    switch_user @admin2

    visit '/account/hosts/new'

    expect(page).to have_selector "form#new_host[action='/account/hosts']"

    within('form#new_host') do
      fill_in 'IP', with: '1.1.1.1'
      fill_in 'Port', with: '22'
      fill_in 'Comment', with: 'host_comment'

      fill_in 'host[host_users_attributes][0][name]', with: 'dev'
      fill_in 'host[host_users_attributes][1][name]', with: 'dev'

      click_button 'Add Host'
    end

    expect(page).to have_current_path('/account/hosts')
    expect(page).to have_content "has already been taken"
  end

  scenario 'admin2 update a old Host', js: true do
    switch_user @admin2

    visit "/account/hosts/#{@admin_host2.id}/edit"

    expect(page).to have_selector "form#edit_host_#{@admin_host2.id}[action='/account/hosts/#{@admin_host2.id}']"

    within("form#edit_host_#{@admin_host2.id}") do
      fill_in 'IP', with: '9.9.9.9'
      fill_in 'Port', with: '1022'
      fill_in 'Comment', with: 'new_host_comment'
      click_button 'Update Host'
    end

    expect(page).to have_current_path('/account/hosts')
    user_sees_flash_notice 'Host was successfully updated.'

    expect(page).to have_content '9.9.9.9'
    expect(page).to have_content '1022'
    expect(page).to have_content 'new_host_comment'
  end

  scenario 'admin2 delete a old host', js: true do
    switch_user @admin2

    visit '/account/hosts'

    find("a[href='/account/hosts/#{@admin_host2.id}']").click

    accept_confirm

    expect(page).to have_current_path('/account/hosts')
    user_sees_flash_notice 'Host was successfully destroyed.'

    expect(page).to_not have_selector "a[href='/account/hosts/#{@admin_host2.id}']"
  end
end

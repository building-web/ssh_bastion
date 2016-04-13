require 'rails_helper'

RSpec.feature "Account::Hosts", type: :feature do
  background do
    @code1 = SecureRandom.hex(4)
    @code2 = SecureRandom.hex(4)

    @admin = create :admin_with_enabled_two_factor, password: 'password'
    @admin_host = create :host, creator_account: @admin, ip: '127.0.0.1', port: '22', code: @code1, comment: 'host_comment'

    @admin1 = create :admin_with_enabled_two_factor, password: 'password'
  end

  scenario "the 'Hosts' sidebar should active" do
    sign_in_user_with @admin.email, password: 'password'

    visit '/account/hosts'

    expect(page).to have_selector "a.active[href='/account/hosts']"
  end

  scenario 'admin1 show ssh_key list' do
    sign_in_user_with @admin1.email, password: 'password'

    visit '/account/hosts'

    expect(page).to have_content 'There are no hosts avaliable to your account.'

    expect(page).to have_selector "a[href='/account/hosts/new']", text: 'New Host'
  end

  scenario 'admin show ssh_key list' do
    sign_in_user_with @admin.email, password: 'password'

    visit '/account/hosts'

    expect(page).to have_content '127.0.0.1'
    expect(page).to have_content '22'
    expect(page).to have_content 'host_comment'
    expect(page).to have_content @code1

    expect(page).to have_selector "a[href='/account/hosts/new']", text: 'New Host'
  end

  scenario 'admin add a new Host' do
    sign_in_user_with @admin.email, password: 'password'

    visit '/account/hosts/new'

    expect(page).to have_selector "form#new_account_host[action='/account/hosts']"

    within('form#new_account_ssh_key') do
      fill_in 'ip', with: '8.8.8.8'
      fill_in 'port', with: '22'
      fill_in 'code', with: @code2
      fill_in  'comment', with: 'host_comment'
      click_button 'Add Host'
    end

    expect(page).to have_current_path('/account/hosts')
    user_sees_flash_notice 'Host was successfully created.'

    expect(page).to have_content '8.8.8.8'
    expect(page).to have_content '22'
    expect(page).to have_content @code2
    expect(page).to have_content 'host_comment'
  end

  scenario 'admin add a new Host that ip is exist' do
    sign_in_user_with @admin.email, password: 'password'

    visit '/account/hosts/new'

    expect(page).to have_selector "form#new_account_host[action='/account/hosts']"

    within('form#new_account_ssh_key') do
      fill_in 'ip', with: '127.0.0.1'
      fill_in 'port', with: '22'
      fill_in 'code', with: @code2
      fill_in  'comment', with: 'host_comment'
      click_button 'Add Host'
    end

    expect(page).to have_current_path('/account/hosts')
    user_sees_flash_notice 'ip has already been taken'
  end

  scenario 'admin add a new Host that ip is invalid' do
    sign_in_user_with @admin.email, password: 'password'

    visit '/account/hosts/new'

    expect(page).to have_selector "form#new_account_host[action='/account/hosts']"

    within('form#new_account_ssh_key') do
      fill_in 'ip', with: 'ip'
      fill_in 'port', with: '22'
      fill_in 'code', with: @code2
      fill_in  'comment', with: 'host_comment'
      click_button 'Add Host'
    end

    expect(page).to have_current_path('/account/hosts')
    user_sees_flash_notice 'ip is invalid'
  end

  scenario 'admin add a new Host that code is exist' do
    sign_in_user_with @admin.email, password: 'password'

    visit '/account/hosts/new'

    expect(page).to have_selector "form#new_account_host[action='/account/hosts']"

    within('form#new_account_ssh_key') do
      fill_in 'ip', with: '8.8.8.8'
      fill_in 'port', with: '22'
      fill_in 'code', with: @code1
      fill_in  'comment', with: 'host_comment'
      click_button 'Add Host'
    end

    expect(page).to have_current_path('/account/hosts')
    user_sees_flash_notice 'code has already been taken'
  end

  scenario 'admin update old Host' do
    sign_in_user_with @admin.email, password: 'password'

    visit "/account/hosts/"

    expect(page).to have_selector "a[href='/account/hosts/#{@admin_host.id}']", text: 'Update'

    find("a[href='/account/hosts/#{@admin_host.id}']").click

    expect(page).to have_selector "form#update_account_host[action='/account/host/#{@admin_host.id}']"

    within('form#update_account_ssh_key') do
      fill_in 'ip', with: '8.8.8.8'
      fill_in 'port', with: '22'
      fill_in 'code', with: @code2
      fill_in  'comment', with: 'host_comment_update'
      click_button 'Update Host'
    end

    expect(page).to have_current_path('/account/hosts')
    user_sees_flash_notice 'Host was successfully update.'

    expect(page).to have_content '8.8.8.8'
    expect(page).to have_content '22'
    expect(page).to have_content @code2
    expect(page).to have_content 'host_comment_update'
  end

  scenario 'admin delete a old host' do
    sign_in_user_with @admin.email, 'password'

    visit '/account/hosts'

    expect(page).to have_selector "a[href='/account/hosts/#{@admin_host.id}']", text: 'Delete'

    find("a[href='/account/hosts/#{@admin_host.id}']").click

    accept_confirm

    expect(page).to have_current_path('/account/hosts')
    user_sees_flash_notice 'Host was successfully destroyed.'

    expect(page).to_not have_selector "a[href='/account/hosts/#{@admin_host.id}']"
  end
end
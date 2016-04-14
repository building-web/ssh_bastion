require 'rails_helper'

RSpec.feature "Account::AccountSshKeys", type: :feature do

  background do
    # user1 is a new user
    @user1 = create :user
    @user1_ssh_public_key = generate_ssh_public_key('RSA', 'user1@example.com')

    # user2 is not a new user, he was created a ssh_key
    @user2 = create :user
    @user2_ssh_public_key = generate_ssh_public_key('RSA', 'user2@example.com')
    _, _, comment = @user2_ssh_public_key.split(' ')
    @user2_ssh_key = create :account_ssh_key, account: @user2, title: 'user2_first_ssh_key', key: @user2_ssh_public_key, comment: comment

    @user2_new_ssh_public_key = generate_ssh_public_key('RSA', 'user2_new@example.com')
  end

  scenario "the 'SSH keys' sidebar should active" do
    switch_user @user1

    visit '/account/ssh_keys'

    expect(page).to have_selector "a.active[href='/account/ssh_keys']"
  end

  scenario 'user1 show ssh_key list' do
    switch_user @user1

    visit '/account/ssh_keys'

    expect(page).to have_content 'There are no SSH keys with access to your account.'
  end

  scenario 'user2 show ssh_key list' do
    switch_user @user2

    visit '/account/ssh_keys'

    expect(page).to have_content 'user2_first_ssh_key'
    expect(page).to have_content ssh_public_key_fingerprint(@user2_ssh_public_key)

    expect(page).to have_selector "a[href='/account/ssh_keys/#{@user2_ssh_key.id}']", text: :Delete
  end

  scenario 'user1 add a new ssh_key', js: true do
    switch_user @user1

    visit '/account/ssh_keys'

    expect(page).to have_selector "button#add_ssh_key"

    expect(page).to have_selector "form#new_account_ssh_key[action='/account/ssh_keys']"

    expect(page.find_field('Title', visible: :all).visible?).to eq true
    expect(page.find_field('Key', visible: :all).visible?).to eq true
    expect(page.find_button('Add SSH key', visible: :all).visible?).to eq true

    find('button#add_ssh_key').click

    expect(page).to have_selector "form#new_account_ssh_key[action='/account/ssh_keys']"

    expect(page.find_field('Title').visible?).to eq true
    expect(page.find_field('Key').visible?).to eq true
    expect(page.find_button('Add SSH key').visible?).to eq true

    within('form#new_account_ssh_key') do
      fill_in 'Title', with: 'user1_first_ssh_key'
      fill_in 'Key', with: @user1_ssh_public_key
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    user_sees_flash_notice 'SSH key was successfully created.'

    expect(page).to have_content 'user1_first_ssh_key'
    expect(page).to have_content ssh_public_key_fingerprint(@user1_ssh_public_key)
  end

  scenario 'user2 add a new ssh_key', js: true do
    switch_user @user2

    visit '/account/ssh_keys'

    expect(page).to have_selector "button#add_ssh_key"

    expect(page).to_not have_selector "form#new_account_ssh_key[action='/account/ssh_keys']"

    expect(page.find_field('Title', visible: :all).visible?).to eq false
    expect(page.find_field('Key', visible: :all).visible?).to eq false
    expect(page.find_button('Add SSH key', visible: :all).visible?).to eq false

    find('button#add_ssh_key').click

    expect(page).to have_selector "form#new_account_ssh_key[action='/account/ssh_keys']"

    expect(page.find_field('Title').visible?).to eq true
    expect(page.find_field('Key').visible?).to eq true
    expect(page.find_button('Add SSH key').visible?).to eq true

    within('form#new_account_ssh_key') do
      fill_in 'Title', with: 'user2_new_ssh_key'
      fill_in 'Key', with: @user2_new_ssh_public_key
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    user_sees_flash_notice 'SSH key was successfully created.'

    expect(page).to have_content 'user2_new_ssh_key'
    expect(page).to have_content ssh_public_key_fingerprint(@user2_new_ssh_public_key)
  end

  scenario 'user2 add a invalid ssh_key that Key is exists', js: true do
    switch_user @user2

    visit '/account/ssh_keys'

    find('button#add_ssh_key').click

    within('form#new_account_ssh_key') do
      fill_in 'Title', with: 'user2_new_ssh_key'
      fill_in 'Key', with: @user2_ssh_public_key
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    expect(page).to have_content 'has already been taken'
  end

  scenario 'user2 add a invalid ssh_key that Key is invalid', js: true do
    switch_user @user2

    visit '/account/ssh_keys'

    find('button#add_ssh_key').click

    within('form#new_account_ssh_key') do
      fill_in 'Title', with: 'user2_new_ssh_key'
      fill_in 'Key', with: 'SSH_KEY'
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    expect(page).to have_content 'is invalid'
  end

  scenario 'user2 add a invalid ssh_key that Title is exists', js: true do
    switch_user @user2

    visit '/account/ssh_keys'

    find('button#add_ssh_key').click

    within('form#new_account_ssh_key') do
      fill_in 'Title', with: 'user2_first_ssh_key'
      fill_in 'Key', with: @user2_new_ssh_public_key
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    expect(page).to have_content 'has already been taken'
  end

  scenario 'user2 delete a old ssh_key', js: true do
    switch_user @user2

    visit '/account/ssh_keys'

    expect(page).to have_selector "a[href='/account/ssh_keys/#{@user2_ssh_key.id}']", text: 'Delete'

    find("a[href='/account/ssh_keys/#{@user2_ssh_key.id}']").click

    accept_confirm

    expect(page).to have_current_path('/account/ssh_keys')
    user_sees_flash_notice 'SSH key was successfully destroyed.'

    expect(page).to_not have_selector "a[href='/account/ssh_keys/#{@user2_ssh_key.id}']"
  end

end

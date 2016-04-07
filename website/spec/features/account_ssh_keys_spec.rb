require 'rails_helper'

RSpec.feature "AccountSshKeys", type: :feature do

  background do
    @user1 = create :user, password: 'password'
    @user1_ssh_public_key = generate_ssh_public_key('RSA', 'user1@example.com')

    @user2 = create :user, password: 'password'
    @user2_ssh_public_key = generate_ssh_public_key('RSA', 'user2@example.com')
    cat, content, comment = @user2_ssh_public_key.split(' ')
    @user2_ssh_key = create :account_ssh_key, account: @user2, title: 'user2_first_ssh_key', cat: cat, content: content, comment: comment

    @user2_new_ssh_public_key = generate_ssh_public_key('RSA', 'user2_new@example.com')
  end

  scenario 'user1 show ssh_key list' do
    sign_in_user_with @user1.email, 'password'

    visit '/account/ssh_keys'

    expect(page).to have_content 'There are no SSH keys with access to your account.'
  end

  scenario 'user2 show ssh_key list' do
    sign_in_user_with @user2.email, 'password'

    visit '/account/ssh_keys'

    expect(page).to have_content 'user2_first_ssh_key'
    expect(page).to have_content ssh_public_key_fingerprint(@user2_ssh_public_key)

    expect(page).to have_selector "a[href='/account/ssh_keys/#{@user2_ssh_key.id}']", text: :Delete
  end

  scenario 'user1 add a new ssh_key' do
    sign_in_user_with @user1.email, 'password'

    visit '/account/ssh_keys'

    expect(page).to have_selector "a#add_ssh_key"

    expect(page).to have_selector "form#new_ssh_key[action='/account/ssh_keys']"

    expect(page.find_field('Title').visible?).to eq true
    expect(page.find_field('Key').visible?).to eq true
    expect(page.find_button('Add SSH key').visible?).to eq true

    find('a#add_ssh_key').click

    expect(page.find_field('Title').visible?).to eq true
    expect(page.find_field('Key').visible?).to eq true
    expect(page.find_button('Add SSH key').visible?).to eq true

    within('form#new_ssh_key') do
      fill_in 'Title', with: 'user1_first_ssh_key'
      fill_in 'Key', with: @user1_ssh_public_key
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    user_sees_flash_notice 'SSH key was successfully created.'

    expect(page).to have_content 'user1_first_ssh_key'
    expect(page).to have_content ssh_public_key_fingerprint(@user1_ssh_public_key)
  end

  scenario 'user2 add a new ssh_key' do
    sign_in_user_with @user2.email, 'password'

    visit '/account/ssh_keys'

    expect(page).to have_selector "a#add_ssh_key"

    expect(page).to have_selector "form#new_ssh_key[action='/account/ssh_keys']"

    expect(page.find_field('Title').visible?).to eq false
    expect(page.find_field('Key').visible?).to eq false
    expect(page.find_button('Add SSH key').visible?).to eq false

    find('a#add_ssh_key').click

    expect(page.find_field('Title').visible?).to eq true
    expect(page.find_field('Key').visible?).to eq true
    expect(page.find_button('Add SSH key').visible?).to eq true

    within('form#new_ssh_key') do
      fill_in 'Title', with: 'user2_new_ssh_key'
      fill_in 'Key', with: @user2_new_ssh_public_key
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    user_sees_flash_notice 'SSH key was successfully created.'

    expect(page).to have_content 'user2_new_ssh_key'
    expect(page).to have_content ssh_public_key_fingerprint(@user2_new_ssh_public_key)
  end

  scenario 'user2 add a invalid ssh_key that Key is exists' do
    sign_in_user_with @user2.email, 'password'

    visit '/account/ssh_keys'

    find('a#add_ssh_key').click

    within('form#new_ssh_key') do
      fill_in 'Title', with: 'user2_new_ssh_key'
      fill_in 'Key', with: @user2_ssh_public_key
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    expect(page).to have_content 'Key is already in use'
  end

  scenario 'user2 add a invalid ssh_key that Key is invalid' do
    sign_in_user_with @user2.email, 'password'

    visit '/account/ssh_keys'

    find('a#add_ssh_key').click

    within('form#new_ssh_key') do
      fill_in 'Title', with: 'user2_new_ssh_key'
      fill_in 'Key', with: 'SSH_KEY'
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    expect(page).to have_content 'Key is invalid'
  end

  scenario 'user2 add a invalid ssh_key that Title is exists' do
    sign_in_user_with @user2.email, 'password'

    visit '/account/ssh_keys'

    find('a#add_ssh_key').click

    within('form#new_ssh_key') do
      fill_in 'Title', with: 'user2_first_ssh_key'
      fill_in 'Key', with: @user2_new_ssh_public_key
      click_button 'Add SSH key'
    end

    expect(page).to have_current_path('/account/ssh_keys')
    expect(page).to have_content 'Title is already in use'
  end

end

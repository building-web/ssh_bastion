require 'rails_helper'

RSpec.feature "Account::Dashboard", type: :feature do

  background do
    # new user
    @user1 = create :user, password: 'password'

    # was submitted a ssh_key
    @user2 = create :user, password: 'password'
    create :account_ssh_key, account: @user2

    # was submitted a ssh_key and enabled two-factor_authentication
    @user3 = create :user_with_enabled_two_factor, password: 'password'
    create :account_ssh_key, account: @user3

    # new admin
    @admin1 = create :admin, password: 'password'

    # was submitted a ssh_key
    @admin2 = create :admin, password: 'password'
    create :account_ssh_key, account: @admin2

    # was submitted a ssh_key and enabled two-factor_authentication
    @admin3 = create :admin_with_enabled_two_factor, password: 'password'
    create :account_ssh_key, account: @admin3
  end

  scenario "the 'Dashboard' navbar should active" do
    sign_in_user_with @user1.email, 'password'

    visit '/account'

    expect(page).to have_selector "a.active[href='/account']"
  end

  scenario 'user1 visit' do
    sign_in_user_with @user1.email, 'password'

    expect(page).to have_selector "a[href='/account']", text: :Dashboard
    expect(page).to have_selector "a[href='/account/profile']", text: :Profile
    expect(page).to have_selector "a[href='/accounts/sign_out']", text: :'Sign out'

    expect(page).to have_selector "a[href='/account/ssh_keys']", text: :'SSH keys'
    expect(page).to have_selector "a[href='/account/two_factor_authentication']", text: :'Two-factor authentication'

    expect(page).to_not have_selector "a[href='/account/hosts']", text: :Hosts
  end

  scenario 'user2 visit' do
    sign_in_user_with @user2.email, 'password'

    expect(page).to_not have_selector "a[href='/account/hosts']", text: :Hosts
  end

  scenario 'user3 visit' do
    sign_in_user_with @user3.email, 'password'

    expect(page).to_not have_selector "a[href='/account/hosts']", text: :Hosts
    expect(page).to have_selector "a[href='/account/assigned_hosts']", text: :'Assigned Hosts'
  end

  scenario 'admin1 visit' do
    sign_in_user_with @admin1.email, 'password'

    expect(page).to have_selector "a[href='/account']", text: :Dashboard
    expect(page).to have_selector "a[href='/account/profile']", text: :Profile
    expect(page).to have_selector "a[href='/accounts/sign_out']", text: :'Sign out'

    expect(page).to have_selector "a[href='/account/ssh_keys']", text: :'SSH keys'
    expect(page).to have_selector "a[href='/account/two_factor_authentication']", text: :'Two-factor authentication'

    expect(page).to_not have_selector "a[href='/account/hosts']", text: :Hosts
  end

  scenario 'admin2 visit' do
    sign_in_user_with @admin2.email, 'password'

    expect(page).to_not have_selector "a[href='/account/hosts']", text: :Hosts
  end

  scenario 'admin3 visit' do
    sign_in_user_with @admin3.email, 'password'

    expect(page).to have_selector "a[href='/account/hosts']", text: :Hosts
    expect(page).to have_selector "a[href='/account/assigned_hosts']", text: :'Assigned Hosts'
    expect(page).to have_selector "a[href='/account/bastion_hosts']", text: :'Bastion hosts'
  end

end

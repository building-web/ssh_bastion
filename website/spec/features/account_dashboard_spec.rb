require 'rails_helper'

RSpec.feature "AccountDashboard", type: :feature do

  background do
    @admin1 = create :admin, password: 'password'

    @admin2 = create :admin, password: 'password'
    create :ssh_key, account: @admin2

    @admin3 = create :admin_with_enabled_two_factor, password: 'password'
    create :ssh_key, account: @admin3

    @user1 = create :user, password: 'password'

    @user2 = create :user, password: 'password'
    create :ssh_key, account: @user2

    @user3 = create :user_with_enabled_two_factor, password: 'password'
    create :ssh_key, account: @user3
  end

  scenario 'visit by a new user' do
    sign_in_user_with @user1.email, 'password'

    expect(page).to have_selector "a[href='/account']", text: :Dashboard
    expect(page).to have_selector "a[href='/account/profile']", text: :Profile
    expect(page).to have_selector "a[href='/accounts/sign_out']", text: :'Sign out'

    expect(page).to have_selector "a[href='/account/ssh_keys']", text: :'SSH keys'
    expect(page).to have_selector "a[href='/account/two_factor_authentication']", text: :'Two-factor authentication'

    expect(page).to_not have_selector "a[href='/account/hosts']", text: :Hosts
  end

  scenario 'visit by a user that was submitted a ssh_key' do
    sign_in_user_with @user2.email, 'password'

    expect(page).to_not have_selector "a[href='/account/hosts']", text: :Hosts
  end

  scenario 'visit by a user that was submitted a ssh_key and enabled two-factor_authentication' do
    sign_in_user_with @user3.email, 'password'

    expect(page).to have_selector "a[href='/account/hosts']", text: :Hosts
  end

  scenario 'visit by a new admin' do
    sign_in_user_with @admin1.email, 'password'

    expect(page).to have_selector "a[href='/account']", text: :Dashboard
    expect(page).to have_selector "a[href='/account/profile']", text: :Profile
    expect(page).to have_selector "a[href='/accounts/sign_out']", text: :'Sign out'

    expect(page).to have_selector "a[href='/account/ssh_keys']", text: :'SSH keys'
    expect(page).to have_selector "a[href='/account/two_factor_authentication']", text: :'Two-factor authentication'

    expect(page).to_not have_selector "a[href='/account/hosts']", text: :Hosts
  end

  scenario 'visit by a admin that was submitted a ssh_key' do
    sign_in_user_with @admin2.email, 'password'

    expect(page).to_not have_selector "a[href='/account/hosts']", text: :Hosts
  end

  scenario 'visit by a admin that was submitted a ssh_key and enabled two-factor_authentication' do
    sign_in_user_with @admin3.email, 'password'

    expect(page).to have_selector "a[href='/account/hosts']", text: :Hosts
    expect(page).to have_selector "a[href='/account/bastion_hosts']", text: :'Bastion hosts'
  end

end

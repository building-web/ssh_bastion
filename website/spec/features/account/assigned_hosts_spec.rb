require 'rails_helper'

RSpec.feature "Account::AssignedHost", type: :feature do
  background do
    @host = create :host
    @host_user = create :host_user, host: @host

    @user1 = create :user_with_enabled_two_factor
    create :account_ssh_key, account: @user1

    @user2 = create :user_with_enabled_two_factor
    create :account_ssh_key, account: @user2
    create :accounts_host_user, account: @user2, host_user: @host_user

    @admin1 = create :admin_with_enabled_two_factor
    create :account_ssh_key, account: @admin1

    @admin2 = create :admin_with_enabled_two_factor
    create :account_ssh_key, account: @admin2
    create :accounts_host_user, account: @admin2, host_user: @host_user
  end

  scenario "the 'Hosts' sidebar should active" do
    switch_user @user1

    visit '/account/assigned_hosts'

    expect(page).to have_selector "a.active[href='/account/assigned_hosts']"
  end

  scenario "user1 show list" do
    switch_user @user1

    visit '/account/assigned_hosts'

    expect(page).to have_content 'There are no hosts assigned to you.'
  end

  scenario 'user2 show list' do
    switch_user @user2

    visit '/account/assigned_hosts'

    expect(page).to have_content @host.ip
    expect(page).to have_content @host.port
    expect(page).to have_content @host.comment
    expect(page).to have_content @host_user.name
  end

  scenario "admin1 show list" do
    switch_user @admin1

    visit '/account/assigned_hosts'

    expect(page).to have_content 'There are no hosts assigned to you.'
  end

  scenario 'admin2 show list' do
    switch_user @admin2

    visit '/account/assigned_hosts'

    expect(page).to have_content @host.ip
    expect(page).to have_content @host.port
    expect(page).to have_content @host.comment
    expect(page).to have_content @host_user.name
  end
end

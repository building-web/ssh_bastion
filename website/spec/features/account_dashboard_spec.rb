require 'rails_helper'

RSpec.feature "AccountDashboard", type: :feature do

  background do
    @admin1 = create :admin, password: 'password'

    @admin2 = create :admin, password: 'password'
    create :accounts_ssh_key, account: @admin2

    @admin3 = create :admin_with_enabled_two_factor, password: 'password'
    create :accounts_ssh_key, account: @admin3

    @user1 = create :user, password: 'password'
    @user2 = create :user, password: 'password'
    create :accounts_ssh_key, account: @user2

    @user3 = create :user_with_enabled_two_factor, password: 'password'
    create :accounts_ssh_key, account: @user3
  end

  scenario 'access by a new user' do
    sign_in_user_with @user1.email, 'password'
  end

  scenario 'access by a user that was submitted a ssh_key'

  scenario 'access by a user that was submitted a ssh_key and enabled two-factor'

end

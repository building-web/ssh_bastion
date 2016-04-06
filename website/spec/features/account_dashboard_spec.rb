require 'rails_helper'

RSpec.feature "AccountDashboard", type: :feature do

  background do
    @admin1 = create :admin

    @admin2 = create :admin
    create :accounts_ssh_key, account: @admin2

    @admin3 = create :admin_with_enabled_two_factor
    create :accounts_ssh_key, account: @admin3

    @user1 = create :user
    @user2 = create :user
    create :accounts_ssh_key, account: @user2

    @user3 = create :user_with_enabled_two_factor
    create :accounts_ssh_key, account: @user3
  end

  scenario 'access by a new user'

  scenario 'access by a user that was submitted a ssh_key'

  scenario 'access by a user that was submitted a ssh_key and enabled two-factor'

end

require 'rails_helper'

RSpec.feature "AccountSshKeysIndex", type: :feature do

  background do
    @user1 = create :user, password: 'password'

    @user2 = create :user, password: 'password'
    create :ssh_key, account: @user2
  end

  scenario 'visit by a new user' do
    sign_in_user_with @user1.email, 'password'

    expect(page).to have_selector "form[action='/account/ssh_keys']"
    expect(page.find_field('key'))
  end

end

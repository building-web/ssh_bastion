require 'rails_helper'

RSpec.feature "AccountSessions", type: :feature do

  background do
    create :account, email: 'person@example.com', password: 'password'
  end

  scenario 'signs the account in successfully with a valid email and password' do
    sign_in_account_with 'person@example.com', 'password'
    user_sees_welcome_message 'Welcome, person@example.com'
  end

  scenario 'notifies the account if his email or password is invalid' do
    sign_in_account_with account.email, 'wrong password'
    account_sees_alert 'Invalid email or password'
  end

end

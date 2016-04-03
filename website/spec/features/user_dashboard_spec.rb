require 'rails_helper'

RSpec.feature "UserDashboard", type: :feature do

  background do
    @user = create :user, email: 'test@example.com', password: 'password'
  end

  scenario 'user cannot submit any ssh_keys' do
    pending
  end

  scenario 'user only was submitted at least one ssh_keys' do
    pending
  end

  scenario 'user was submitted any ssh_keys and enabled two-factor' do
    pending
  end

end

require 'rails_helper'

RSpec.feature "UserSessions", type: :feature do

  background do
    create :user, email: 'person@example.com', password: 'password'
  end

end

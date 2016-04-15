require 'rails_helper'

RSpec.feature "Account::TwoFactorAuthorization", type: :feature do
  background do
    @user1 = create :user_with_enabled_two_factor

    @admin1 = create :admin_with_enabled_two_factor
  end

  scenario "the 'Two-factor authorization' sidebar should active" do
    switch_user @user1

    visit '/account/two_factor_authorization'

    expect(page).to have_selector "a.active[href='/account/two_factor_authorization']"
  end

  scenario "user can see 'Actice' button" do
    switch_user @user1

    visit '/account/two_factor_authorization'

    expect(page).to have_selector "a.herf['/account/two_factor_authorization/new']"
  end
end
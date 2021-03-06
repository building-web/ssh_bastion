require 'rails_helper'

RSpec.feature "Account::Profiles", type: :feature do

  background do
    @user = create :user
  end

  scenario "the 'Profile' navbar should active" do
    switch_user @user

    visit '/account/profile'

    expect(page).to have_selector "a.active[href='/account/profile']"
  end


  scenario 'user enter right current_password and new password to update password' do
    switch_user @user

    visit '/account/profile'

    within('form#edit_profile_password') do
      fill_in 'Current password', with: 'password'
      fill_in 'New password', with: 'new_password'
      fill_in 'New password confirmation', with: 'new_password'
      click_button 'Submit'
    end

    expect(page).to have_current_path('/account')
    user_sees_flash_notice 'Your password has been changed successfully.'
  end

  scenario 'user enter wrong current_password and new password to update password' do
    switch_user @user

    visit '/account/profile'

    within('form#edit_profile_password') do
      fill_in 'Current password', with: 'wrong_password'
      fill_in 'New password', with: 'new_password'
      fill_in 'New password confirmation', with: 'new_password'
      click_button 'Submit'
    end

    expect(page).to have_content('is invalid')
  end

end
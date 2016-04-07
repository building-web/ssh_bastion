require 'rails_helper'

RSpec.feature "AccountSshKeysIndex", type: :feature do

  background do
    @user1 = create :user, password: 'password'
    @user1_ssh_public_key = generate_ssh_public_key('RSA', 'user1@example.com')

    @user2 = create :user, password: 'password'
    @user2_ssh_public_key = generate_ssh_public_key('RSA', 'user2@example.com')
    cat, content, comment = @user2_ssh_public_key.split(' ')
    create :account_ssh_key, account: @user2, cat: cat, content: content, comment: comment
  end

  scenario 'visit by a new user' do
    sign_in_user_with @user1.email, 'password'

    visit '/account/ssh_keys'

    expect(page).to have_selector "form#new_ssh_key[action='/account/ssh_keys']"
    expect(page.find_field('Title').visible?).to eq true
    expect(page.find_field('Key').visible?).to eq true
    expect(page.find_button('Add SSH key').visible?).to eq true

    within('form#new_ssh_key') do
      fill_in 'Title', with: 'my_ssh_key'
      fill_in 'Key', with: @user1_ssh_public_key
    end
  end

end

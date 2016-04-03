module Features

  def sign_in_user_with(email, password)
    visit sign_in_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign In'
  end

end

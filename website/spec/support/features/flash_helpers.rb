module Features

  def user_sees_flash_notice(text)
    expect(page).to have_css '.flash.alert-success', text: text
  end

  def user_sees_flash_alert(text)
    expect(page).to have_css '.flash.alert-danger', text: text
  end

end

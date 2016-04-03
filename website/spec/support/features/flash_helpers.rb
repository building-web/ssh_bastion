module Features

  def user_sees_flash_notice(text)
    expect(page).to have_css '.flash.notice', text: text
  end

  def user_sees_flash_alert(text)
    expect(page).to have_css '.flash.alert', text: text
  end

end

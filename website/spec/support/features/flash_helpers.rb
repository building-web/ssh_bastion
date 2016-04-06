module Features

  def user_sees_flash_notice(text)
    expect(page).to have_css '.flash.alert-success', text: text
  end

  alias_method :admin_sees_flash_notice, :user_sees_flash_notice

  def user_sees_flash_alert(text)
    expect(page).to have_css '.flash.alert-danger', text: text
  end

  alias_method :admin_sees_flash_alert, :user_sees_flash_alert

end

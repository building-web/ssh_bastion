module Features

  def accept_confirm
    case Capybara.javascript_driver
    when :selenium
      page.driver.browser.switch_to.alert.accept
    when :webkit
      # TODO
      page.accept_confirm
    else
    end
  end

end

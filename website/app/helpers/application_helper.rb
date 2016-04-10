module ApplicationHelper

  def account_nav_is?(nav)
    case nav.to_s.to_sym
    when :account_ssh_keys
      controller_name == 'account_ssh_keys'
    else
      false
    end
  end

end

module ApplicationHelper

  def account_nav_is?(nav)
    case nav.to_s.to_sym
    when :dashboard
      controller_name == 'main' and action_name == 'dashboard'
    when :account_ssh_keys
      controller_name == 'account_ssh_keys'
    when :profile
      controller_name == 'profiles'
    else
      false
    end
  end

end

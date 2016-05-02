module ApplicationHelper

  def account_nav_is?(nav)
    case nav.to_s.to_sym
    when :dashboard
      controller_name == 'main' and action_name == 'dashboard'
    when :account_ssh_keys
      controller_name == 'account_ssh_keys'
    when :profile
      controller_name == 'profiles'
    when :hosts
      controller_name == 'hosts'
    when :accounts
      controller_name == 'accounts'
    when :assigned_hosts
      controller_name == 'assigned_hosts'
    when :two_factor_authentication
      controller_name == 'two_factor_authentications'
    else
      false
    end
  end

end

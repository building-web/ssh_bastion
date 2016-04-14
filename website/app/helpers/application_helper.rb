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
    when :assigned_hosts
      controller_name == 'assigned_hosts'
    else
      false
    end
  end

end

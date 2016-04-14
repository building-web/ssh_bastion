class AccountsHostUserPolicy < ApplicationPolicy
  attr_reader :account, :assigned_host

  def initialize(account, assigned_host)
    @account = account
    @assigned_host = assigned_host
  end

  def index?
    account.has_ssh_key? and account.enabled_two_factor_authentication?
  end
end

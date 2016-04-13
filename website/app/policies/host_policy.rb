class HostPolicy < ApplicationPolicy

  attr_reader :account, :host

  def initialize(account, host)
    @account = account
    @host = host
  end

  def index?
    account.submitted_ssh_key? and account.enabled_two_factor_authentication?
  end

  def handle?
    account.submitted_ssh_key? and account.enabled_two_factor_authentication? and account.role?(:admin)
  end
end
class HostPolicy < ApplicationPolicy

  attr_reader :account, :host

  def initialize(account, host)
    @account = account
    @host = host
  end

  def index?
    host_operator?
  end

  def new?
    host_operator?
  end

  def create?
    host_operator?
  end

  def edit?
    host_operator?
  end

  def update?
    host_operator?
  end

  def destroy?
    host_operator?
  end

  private
  def host_operator?
    account.submitted_ssh_key? and account.enabled_two_factor_authentication? and account.role?(:admin)
  end
end
class HostPolicy < ApplicationPolicy

  attr_reader :account, :host

  def initialize(account, host)
    @account = account
    @host = host
  end

  def index?
    account.secret_matched?
  end

  def new?
    create?
  end

  def create?
    account.secret_matched? and account.role?(:admin)
  end

  def edit?
    update?
  end

  def update?
    account.secret_matched? and host.creator_account == account
  end

  def destroy?
    update?
  end

  private

end
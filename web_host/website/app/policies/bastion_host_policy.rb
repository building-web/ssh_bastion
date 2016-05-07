class BastionHostPolicy < ApplicationPolicy

  attr_reader :account, :bastion_host

  def initialize(account, bastion_host)
    @account = account
    @bastion_host = bastion_host
  end

  def index?
    account.role?(:admin)
  end

end
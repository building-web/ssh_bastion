class AccountPolicy < ApplicationPolicy

  attr_reader :account, :two_factor_module

  def initialize(account, two_factor_module)
    @account = account
    @two_factor_module = two_factor_module
  end

  def new?
    !account.enabled_two_factor_authentication?
  end

  private

end
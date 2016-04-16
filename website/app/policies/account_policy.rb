class AccountPolicy < ApplicationPolicy

  attr_reader :account, :two_factor_module

  def initialize(account, two_factor_module)
    @account = account
    @two_factor_module = two_factor_module
  end

  def new?
    !account.secret_matched?
  end

  def destroy?
    update?
  end

  private

end
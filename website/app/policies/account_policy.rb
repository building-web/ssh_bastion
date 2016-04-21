class AccountPolicy < ApplicationPolicy

  attr_reader :account, :two_factor_module

  def initialize(account, two_factor_module)
    @account = account
    @two_factor_module = two_factor_module
  end

  def new?
    !account.enabled_two_factor_authentication?
  end

  def recovery_codes?
    account.enabled_two_factor_authentication? and account.download_at.blank?
  end

  private

end
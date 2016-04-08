class HostPolicy
  attr_reader :account, :host

  def initialize(account, host)
    @account = account
    @admin_module = host
  end

  def index?
    account.role_admin?
  end
end

class AdminModulePolicy
  attr_reader :account, :admin_module

  def initialize(account, admin_module)
    @account = account
    @admin_module = admin_module
  end

  def manage_hosts?
    account.role_admin?
  end
end

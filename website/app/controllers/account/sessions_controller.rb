class Account::SessionsController < Devise::SessionsController

  layout 'account'

  def after_sign_out_path_for(resource_name)
    account_root_path
  end

end

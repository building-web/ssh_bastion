class Account::SessionsController < Devise::SessionsController

  layout 'account_unsigned'

  def after_sign_out_path_for(resource_name)
    root_path
  end

end
